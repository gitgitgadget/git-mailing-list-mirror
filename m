From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach git-apply about '-R'
Date: Fri, 28 Jul 2006 12:20:33 -0700
Message-ID: <7vhd11leny.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<200607262039.25155.Josef.Weidendorfer@gmx.de>
	<20060728013038.GH13776@pasky.or.cz>
	<Pine.LNX.4.63.0607281213250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v3bcln3m5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607281748390.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 28 21:20:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Xt1-0000jr-MM
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 21:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWG1TUg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 15:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbWG1TUf
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 15:20:35 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:49039 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751275AbWG1TUf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jul 2006 15:20:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060728192034.HHBE12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 28 Jul 2006 15:20:34 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607281748390.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 28 Jul 2006 17:50:27 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24401>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 28 Jul 2006, Junio C Hamano wrote:
>> 
>> A quick comment without looking much at the code.  Do you sanely
>> bail out when asked to reverse-apply a binary patch?
>
> Nope. I swap old_sha1_prefix and new_sha1_prefix in that case, I hoped 
> that is enough?

You would need something like this, at least for now, since both
deflated literal and deflated delta methods are irreversible.
I'll cook up another binary diff output that can go
bidirectional.

Note that --allow-binary-replacement uses the blob object name
recorded on index lines of binary patch, and uses it to cheat
(iow, when it knows your version is the old version recorded on
index line and your repository happens to have the resulting
blob, it just uses the blob without looking at the binary
contents recorded in the patch), so you have to work a bit hard
to cause it to fail in t/trash repository after you run t4103
test.  Resetting to "master", apply BF.diff, and immediately
reverse apply BF.diff would _work_, only because "master" and
"binary" branch keep both preimage and postimage.

-- >8 --
diff --git a/builtin-apply.c b/builtin-apply.c
index 6b38a8a..d4381d9 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1535,6 +1535,12 @@ static int apply_binary_fragment(struct 
 	void *data;
 	void *result;
 
+	/* Binary patch is irreversible */
+	if (patch->is_reverse)
+		return error("cannot reverse-apply a binary patch to '%s'",
+			     patch->new_name
+			     ? patch->new_name : patch->old_name);
+
 	data = inflate_it(fragment->patch, fragment->size,
 			  patch->deflate_origlen);
 	if (!data)
