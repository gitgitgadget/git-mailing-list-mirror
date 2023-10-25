Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4741F2D604
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 06:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0467E134
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 23:50:36 -0700 (PDT)
Received: (qmail 7107 invoked by uid 109); 25 Oct 2023 06:50:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Oct 2023 06:50:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32668 invoked by uid 111); 25 Oct 2023 06:50:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Oct 2023 02:50:37 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 25 Oct 2023 02:50:33 -0400
From: Jeff King <peff@peff.net>
To: Michael Strawbridge <michael.strawbridge@amd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: move validation code below
 process_address_list
Message-ID: <20231025065033.GB2094463@coredump.intra.peff.net>
References: <xmqqzg0oiy4s.fsf@gitster.g>
 <20231011224753.GE518221@coredump.intra.peff.net>
 <b4385543-bee0-473b-ab2d-df0d7847ddf3@amd.com>
 <20231020064525.GB1642714@coredump.intra.peff.net>
 <20231020071402.GC1642714@coredump.intra.peff.net>
 <20231020100343.GA2194322@coredump.intra.peff.net>
 <xmqqil71otsa.fsf@gitster.g>
 <20231023185152.GC1537181@coredump.intra.peff.net>
 <393f598e-c7cd-4dc6-a221-9aed7ffcc2b1@amd.com>
 <ee56c4df-e030-45f9-86a9-94fb3540db60@amd.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee56c4df-e030-45f9-86a9-94fb3540db60@amd.com>

On Tue, Oct 24, 2023 at 04:19:43PM -0400, Michael Strawbridge wrote:

> Move validation logic below processing of email address lists so that
> email validation gets the proper email addresses.
> 
> This fixes email address validation errors when the optional
> perl module Email::Valid is installed and multiple addresses are passed
> in on a single to/cc argument like --to=foo@example.com,bar@example.com.

Is there a test we can include here?

> @@ -2023,6 +1999,30 @@ sub process_file {
>  	return 1;
>  }
>  
> +if ($validate) {

So the new spot is right before we call process_file() on each of the
input files. It is a little hard to follow because of the number of
functions defined inline in the middle of the script, but I think that
is a reasonable spot. It is after we have called process_address_list()
on to/cc/bcc, which I think fixes the regression. But it is also after
we sanitize $reply_to, etc, which seems like a good idea.

But I think putting it down that far is the source of the test failures.

The culprit seems not to be the call to validate_patch() in the loop you
moved, but rather pre_process_file(), which was added in your earlier
a8022c5f7b (send-email: expose header information to git-send-email's
sendemail-validate hook, 2023-04-19).

It looks like the issue is the global $message_num variable which is
incremented by pre_process_file(). On line 1755 (on the current tip of
master), we set it to 0. And your patch moves the validation across
there (from line ~799 to ~2023).

And that's why the extra increments didn't matter when you added the
calls to pre_process_file() in your earlier patch; they all happened
before we reset $message_num to 0. But now they happen after.

To be fair, this is absolutely horrific perl code. There's over a
thousand lines of function definitions, and then hidden in the middle
are some global variable assignments!

So we have a few options, I think:

  1. Reset $message_num to 0 after validating (maybe we also need
     to reset $in_reply_to, etc, set at the same time? I didn't check).
     This feels like a hack.

  2. Move the validation down, but not so far down. Like maybe right
     after we set up the @files list with the $compose.final name. This
     is the smallest diff, but feels like we haven't really made the
     world a better place.

  3. Move the $message_num, etc, initialization to right before we call
     the process_file() loop, which is what expects to use them. Like
     this (squashed into your patch):

diff --git a/git-send-email.perl b/git-send-email.perl
index a898dbc76e..d44db14223 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1730,10 +1730,6 @@ sub send_message {
 	return 1;
 }
 
-$in_reply_to = $initial_in_reply_to;
-$references = $initial_in_reply_to || '';
-$message_num = 0;
-
 sub pre_process_file {
 	my ($t, $quiet) = @_;
 
@@ -2023,6 +2019,10 @@ sub process_file {
 	delete $ENV{GIT_SENDEMAIL_FILE_TOTAL};
 }
 
+$in_reply_to = $initial_in_reply_to;
+$references = $initial_in_reply_to || '';
+$message_num = 0;
+
 foreach my $t (@files) {
 	while (!process_file($t)) {
 		# user edited the file

That seems to make the test failures go away. It is still weird that the
validation code is calling pre_process_file(), which increments
$message_num, without us having set it up in any meaningful way. I'm not
sure if there are bugs lurking there or not. I'm not impressed by the
general quality of this code, and I'm kind of afraid to keep looking
deeper.

-Peff
