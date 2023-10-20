Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35884B652
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 06:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716AC98
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 23:45:27 -0700 (PDT)
Received: (qmail 13299 invoked by uid 109); 20 Oct 2023 06:45:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Oct 2023 06:45:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11501 invoked by uid 111); 20 Oct 2023 06:45:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Oct 2023 02:45:30 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Oct 2023 02:45:25 -0400
From: Jeff King <peff@peff.net>
To: Michael Strawbridge <michael.strawbridge@amd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Todd Zullinger <tmz@pobox.com>, Luben Tuikov <luben.tuikov@amd.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Git Mailing List <git@vger.kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] send-email: move process_address_list earlier to avoid,
 uninitialized address error
Message-ID: <20231020064525.GB1642714@coredump.intra.peff.net>
References: <ZRGdvRQuj4zllGnm@pobox.com>
 <20230925161748.GA2149383@coredump.intra.peff.net>
 <ZSal-mQIZAUBaq6g@debian.me>
 <95b9e5d5-ab07-48a6-b972-af5348f653be@amd.com>
 <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
 <xmqq1qe0lui2.fsf@gitster.g>
 <20231011221844.GB518221@coredump.intra.peff.net>
 <xmqqzg0oiy4s.fsf@gitster.g>
 <20231011224753.GE518221@coredump.intra.peff.net>
 <b4385543-bee0-473b-ab2d-df0d7847ddf3@amd.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4385543-bee0-473b-ab2d-df0d7847ddf3@amd.com>

On Fri, Oct 13, 2023 at 04:25:57PM -0400, Michael Strawbridge wrote:

> > I did not look carefully at the flow of send-email, so this may or may
> > not be an issue. But what I think would be _really_ annoying is if you
> > asked to write a cover letter, went through the trouble of writing it,
> > and then send-email bailed due to some validation failure that could
> > have been checked earlier.
> >
> > There is probably a way to recover your work (presumably we leave it in
> > a temporary file somewhere), but it may not be entirely trivial,
> > especially for users who are not comfortable with advanced usage of
> > their editor. ;)
>
> As I was looking at covering the case of interactive input (--compose)
> to the fix I noticed that this seems to be at least partly handled by
> the $compose_filename code.  There is a nice output message telling
> you exactly where the intermediate version of the email you are
> composing is located if there are errors.  I took a quick look inside
> and can verify that any lost work should be minimal as long as someone
> knows how to edit files with their editor of choice.

OK, that makes me feel better about just moving the validation code. A
more complicated solution could be do to do _some_ basic checks up
front, and then more complete validation later. But even if we wanted to
do that, moving the bulk of the validation (as discussed in this thread)
would probably be the first step anyway (and if nobody complains, maybe
we can avoid doing the extra work).

I do wonder if we might find other interesting corner cases where
the validation code (or somebody's hook) isn't happy with seeing the
more "full" picture (i.e., with the extra addresses from interactive and
command-line input). But arguably any such case would be indicative of a
bug, and smoking it out would be a good thing.

> I have been looking into handling the interactive input cases while
> solving this issue, but have yet to make a breakthrough.  Simply
> moving the validation code below the original process_address_list
> code results in a a scenario where I get the email address being seen
> as something like "ARRAY (0x55ddb951d768)" rather than the email
> address I wrote in the compose buffer.

Sounds like something is making a perl ref that shouldn't (or something
that should be dereferencing it not doing so). If you post your patch
and a reproduction command, I might be able to help debug.

But just blindly moving the validation code down, like:

diff --git a/git-send-email.perl b/git-send-email.perl
index 288ea1ae80..76589c7827 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -799,30 +799,6 @@ sub is_format_patch_arg {
 
 $time = time - scalar $#files;
 
-if ($validate) {
-	# FIFOs can only be read once, exclude them from validation.
-	my @real_files = ();
-	foreach my $f (@files) {
-		unless (-p $f) {
-			push(@real_files, $f);
-		}
-	}
-
-	# Run the loop once again to avoid gaps in the counter due to FIFO
-	# arguments provided by the user.
-	my $num = 1;
-	my $num_files = scalar @real_files;
-	$ENV{GIT_SENDEMAIL_FILE_TOTAL} = "$num_files";
-	foreach my $r (@real_files) {
-		$ENV{GIT_SENDEMAIL_FILE_COUNTER} = "$num";
-		pre_process_file($r, 1);
-		validate_patch($r, $target_xfer_encoding);
-		$num += 1;
-	}
-	delete $ENV{GIT_SENDEMAIL_FILE_COUNTER};
-	delete $ENV{GIT_SENDEMAIL_FILE_TOTAL};
-}
-
 @files = handle_backup_files(@files);
 
 if (@files) {
@@ -1121,6 +1097,30 @@ sub expand_one_alias {
 	$reply_to = sanitize_address($reply_to);
 }
 
+if ($validate) {
+	# FIFOs can only be read once, exclude them from validation.
+	my @real_files = ();
+	foreach my $f (@files) {
+		unless (-p $f) {
+			push(@real_files, $f);
+		}
+	}
+
+	# Run the loop once again to avoid gaps in the counter due to FIFO
+	# arguments provided by the user.
+	my $num = 1;
+	my $num_files = scalar @real_files;
+	$ENV{GIT_SENDEMAIL_FILE_TOTAL} = "$num_files";
+	foreach my $r (@real_files) {
+		$ENV{GIT_SENDEMAIL_FILE_COUNTER} = "$num";
+		pre_process_file($r, 1);
+		validate_patch($r, $target_xfer_encoding);
+		$num += 1;
+	}
+	delete $ENV{GIT_SENDEMAIL_FILE_COUNTER};
+	delete $ENV{GIT_SENDEMAIL_FILE_TOTAL};
+}
+
 if (!defined $sendmail_cmd && !defined $smtp_server) {
 	my @sendmail_paths = qw( /usr/sbin/sendmail /usr/lib/sendmail );
 	push @sendmail_paths, map {"$_/sendmail"} split /:/, $ENV{PATH};

seems to fix the problem from this thread and passes the existing tests.
Manually inspecting the result (and what's fed to the validation hook) I
don't see anything odd (like "ARRAY (...)").

-Peff
