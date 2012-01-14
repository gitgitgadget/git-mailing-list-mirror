From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v4 00/10] nd/clone-detached
Date: Sat, 14 Jan 2012 14:40:36 +0700
Message-ID: <20120114074036.GA27256@do>
References: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
 <1326439322-15648-1-git-send-email-pclouds@gmail.com>
 <7vvcofxtv8.fsf@alter.siamese.dyndns.org>
 <CACsJy8DggQdM1aoeL+u=3Wz+5f7hi4eG=6MHXPCJZ6pOmhQJ_w@mail.gmail.com>
 <7vhazyyduw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 14 08:41:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlyF2-0000ic-5G
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 08:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578Ab2ANHlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 02:41:07 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63146 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab2ANHlF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 02:41:05 -0500
Received: by iaby12 with SMTP id y12so440695iab.19
        for <git@vger.kernel.org>; Fri, 13 Jan 2012 23:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nDrqIXyUnKT8rmHt3GL+PMhBhYY0IOH8cqCGvlG7dJM=;
        b=t2VRAIRzF94UXD6I0zf3GKTqduu+fqiHQGN0gDQDtC2gja3qlm6IUcnS/jlyTRE9Xw
         di1pvNdB4s4S2jqiQbfDqLB2pk3Sum6qU9zeq7YhEVHQISej/coK2guVWOLVj7bqVuMr
         K1rXEFtHgv280LBceS4KjiUwMAWbX930S26So=
Received: by 10.42.176.66 with SMTP id bd2mr3695520icb.32.1326526865245;
        Fri, 13 Jan 2012 23:41:05 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.41.201])
        by mx.google.com with ESMTPS id gh7sm19211882igb.1.2012.01.13.23.41.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 Jan 2012 23:41:04 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 14 Jan 2012 14:40:36 +0700
Content-Disposition: inline
In-Reply-To: <7vhazyyduw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188554>

On Fri, Jan 13, 2012 at 10:53:11PM -0800, Junio C Hamano wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
> > 2012/1/14 Junio C Hamano <gitster@pobox.com>:
> >> Thanks, replaced (and updated comment strings read much better).
> >>
> >> There were some conlicts I had to resolve while merging this to 'pu'.
> >> I would appreciate it if you can eyeball it to make sure I didn't make
> >> silly mistakes there.
> >
> > Right, the conflict with nd/clone-single-branch. I kept thinking there
> > would not be conflict because clone-single-branch's big change was in
> > wanted_peer_refs() and missed write_followtags() call. The merge looks
> > good.
> 
> Hmm, 'pu' seems to fail its selftest with this merge present, though.

The commit "refuse to clone if --branch points to bogus ref" from this
series changes clone's behavior that t5500.31, which is added in
nd/clone-single-branch, relies on. This makes "make test" pass for me
on pu:

-- 8< --
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 7e85c71..c4e675f 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -283,10 +283,7 @@ test_expect_success 'clone shallow object count' '
 '
 
 test_expect_success 'clone shallow with nonexistent --branch' '
-	git clone --depth 1 --branch Z "file://$(pwd)/." shallow4 &&
-	GIT_DIR=shallow4/.git git rev-parse HEAD >actual &&
-	git rev-parse HEAD >expected &&
-	test_cmp expected actual
+	test_must_fail git clone --depth 1 --branch Z "file://$(pwd)/." shallow4
 '
 
 test_expect_success 'clone shallow with detached HEAD' '
-- 8< --

I'd rather remove the test, but removing something in a merge does not
sound wise.

Another cleaner approach is to combine the two clone series into
one. If you want to go this way, pick one as base, I'll rebase the
other on top and resend.
-- 
Duy
