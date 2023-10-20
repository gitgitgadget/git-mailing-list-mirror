Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DB3D2E0
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB951CA
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 00:14:04 -0700 (PDT)
Received: (qmail 13454 invoked by uid 109); 20 Oct 2023 07:14:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Oct 2023 07:14:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11647 invoked by uid 111); 20 Oct 2023 07:14:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Oct 2023 03:14:07 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Oct 2023 03:14:02 -0400
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
Message-ID: <20231020071402.GC1642714@coredump.intra.peff.net>
References: <20230925161748.GA2149383@coredump.intra.peff.net>
 <ZSal-mQIZAUBaq6g@debian.me>
 <95b9e5d5-ab07-48a6-b972-af5348f653be@amd.com>
 <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
 <xmqq1qe0lui2.fsf@gitster.g>
 <20231011221844.GB518221@coredump.intra.peff.net>
 <xmqqzg0oiy4s.fsf@gitster.g>
 <20231011224753.GE518221@coredump.intra.peff.net>
 <b4385543-bee0-473b-ab2d-df0d7847ddf3@amd.com>
 <20231020064525.GB1642714@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020064525.GB1642714@coredump.intra.peff.net>

On Fri, Oct 20, 2023 at 02:45:25AM -0400, Jeff King wrote:

> > I have been looking into handling the interactive input cases while
> > solving this issue, but have yet to make a breakthrough.  Simply
> > moving the validation code below the original process_address_list
> > code results in a a scenario where I get the email address being seen
> > as something like "ARRAY (0x55ddb951d768)" rather than the email
> > address I wrote in the compose buffer.
> 
> Sounds like something is making a perl ref that shouldn't (or something
> that should be dereferencing it not doing so). If you post your patch
> and a reproduction command, I might be able to help debug.

Ah, your "address I wrote in the compose buffer" was the clue I needed.

I think this is actually an existing bug. If I use --compose and write:

  To: foo@example.com

in the editor, we read that back in and handle it in parse_header_line()
like:

        my $addr_pat = join "|", qw(To Cc Bcc);

        foreach (split(/\n/, $lines)) {
                if (/^($addr_pat):\s*(.+)$/i) {
                        $parsed_line->{$1} = [ parse_address_line($2) ];
                } elsif (/^([^:]*):\s*(.+)\s*$/i) {
                        $parsed_line->{$1} = $2;
                }
        }

and there's your perl array ref (from the square brackets, which are
necessary because we're sticking it in a hash value). But even before
your patch, this seems to end up as garbage. The code which reads
$parsed_line does not dereference the array.

The patch to fix it is only a few lines (well, more than that with some
light editorializing in the comments):

diff --git a/git-send-email.perl b/git-send-email.perl
index 76589c7827..46a30088c9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -918,7 +918,28 @@ sub get_patch_subject {
 	# Preserve unknown headers
 	foreach my $key (keys %parsed_email) {
 		next if $key eq 'body';
-		print $c2 "$key: $parsed_email{$key}";
+
+		# it seems like it would be easier to just look for
+		# $parsed_email{'To'} and so on. But we actually match
+		# these case-insenstively and preserve the user's spelling, so
+		# we might see $parsed_email{'to'}. Of course, the same bug
+		# exists for Subject, etc, above. Anyway, a "/i" regex here
+		# handles all cases.
+		#
+		# It kind of feels like all of this code would be much simpler
+		# if we just handled all of the headers while reading back the
+		# input, rather than stuffing them all into $parsed_email and
+		# then picking them out of it.
+		#
+		# It also really feels like these to/cc/bcc lines should be
+		# added to the regular ones? It is silly to make a cover letter
+		# that goes to some addresses, and then not send the patches to
+		# them, too.
+		if ($key =~ /^(To|Cc|Bcc)$/i) {
+			print $c2 "$key: ", join(', ', @{$parsed_email{$key}});
+		} else {
+			print $c2 "$key: $parsed_email{$key}";
+		}
 	}
 
 	if ($parsed_email{'body'}) {

I don't really think your patch makes things worse here. But it is
probably worth fixing it while we are here.

-Peff
