From: Jeff King <peff@peff.net>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Fri, 4 Nov 2011 23:55:42 -0400
Message-ID: <20111105035542.GA1974@sigill.intra.peff.net>
References: <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org>
 <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
 <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
 <CA+55aFzstE-+NzfSAWMEokB7-rYsZOcZe9Ez-LxPNOKnciJ3UQ@mail.gmail.com>
 <7vlirvbq47.fsf@alter.siamese.dyndns.org>
 <7v39e3bn1n.fsf@alter.siamese.dyndns.org>
 <CA+55aFzKPPqwGOe5Ov0FHF1DHbKmNhm=ePvcaY5uqR7cwFhQGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-ide-owner@vger.kernel.org Sat Nov 05 04:55:49 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RMXMB-00083p-FO
	for lnx-linux-ide@lo.gmane.org; Sat, 05 Nov 2011 04:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550Ab1KEDzq (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Fri, 4 Nov 2011 23:55:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33855
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753492Ab1KEDzp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Nov 2011 23:55:45 -0400
Received: (qmail 7441 invoked by uid 107); 5 Nov 2011 03:55:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 Nov 2011 23:55:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Nov 2011 23:55:42 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzKPPqwGOe5Ov0FHF1DHbKmNhm=ePvcaY5uqR7cwFhQGQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184817>

On Fri, Nov 04, 2011 at 04:10:59PM -0700, Linus Torvalds wrote:

> I'm pretty sure people have already done "git merge v3.1" kind of
> things using local tags (where no peeling of FETCH_HEAD has been
> done). See
> 
>     git log --merges --grep 'Merge.*v[23]\.[0-9]'
> 
> for a ton of examples of this (and there's something odd going on: we
> have "Merge commit .." and "Merge tag ..", and I suspect the latter is
> people editing it to be correct by hand, but I dunno).

It looks like fmt-merge-msg looks in FETCH_HEAD to see if each line is
marked as "branch" or "tag". So I get "Merge tag ..." with:

  git pull . tag v1.0

but I get "Merge commit ..." with:

  git merge v1.0

When "git merge" is run, it actually creates a fake FETCH_HEAD in memory
and feeds it to fmt-merge-msg. But that process doesn't seem to bother
looking at tags. I think we just need this:

---
diff --git a/builtin/merge.c b/builtin/merge.c
index dffd5ec..6a44b6d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -439,10 +439,15 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		if (!prefixcmp(found_ref, "refs/heads/")) {
 			strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
 				    sha1_to_hex(branch_head), remote);
 			goto cleanup;
 		}
+		if (!prefixcmp(found_ref, "refs/tags/")) {
+			strbuf_addf(msg, "%s\t\ttag '%s' of .\n",
+				    sha1_to_hex(branch_head), remote);
+			goto cleanup;
+		}
 		if (!prefixcmp(found_ref, "refs/remotes/")) {
 			strbuf_addf(msg, "%s\t\tremote-tracking branch '%s' of .\n",
 				    sha1_to_hex(branch_head), remote);
 			goto cleanup;
 		}

where the result of merge_name is just fed to fmt-merge-msg eventually.

-Peff
