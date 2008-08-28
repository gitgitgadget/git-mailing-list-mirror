From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: git-shortlog hangs on bare repo without --bare option
Date: Thu, 28 Aug 2008 14:16:07 +0700
Message-ID: <fcaeb9bf0808280016k7378cc0ev985f90b270f615e5@mail.gmail.com>
References: <20080827195233.GA2477@garry-thinkpad.arpnetworks.com>
	 <48B5C9E4.4030807@lsrfire.ath.cx>
	 <7vvdxmm78o.fsf@gitster.siamese.dyndns.org>
	 <7vod3em67d.fsf@gitster.siamese.dyndns.org>
	 <7v8wuim4kv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"=?UTF-8?Q?Ren=C3=A9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 09:17:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYbkq-0001x0-3e
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 09:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbYH1HQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 03:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbYH1HQK
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 03:16:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:32308 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbYH1HQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 03:16:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so183147fgg.17
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NI7llrJcNudMGOUvrSUBW1Yt1LTyzyFrmGls8tjOvpQ=;
        b=oLr7TDiGgpIjWqwPjabE8COsLT/3D1vHPQVtb7xvA+9P9xoJwWEDf0S9lrRXcKiHSt
         mNRXSqxyu6vsVmoz51wH5Lxe22XMM7sKkg0hOe4LmHckaYa0G1jbrfToDeLODc91EL1n
         gyG/8pbFQlAM1chvz77XcvnHF8umh7wxWHdus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oKtKhv8yf4jAsu0r+HJKoJ75M3zXnv10NmRSEx+mnONqo5aO4VPJ9+UcbdOj0ZJQ1X
         fA8t5VAtJ6qgv9sviebPjHrF0Rjd3hDnk4+jgxQfN8pULs8h8Eap/6eQ2K+4sD18uf5J
         b4Gdmm8ewGAcrbsKBdq7gYgxR7f7JfhMOwLds=
Received: by 10.86.57.9 with SMTP id f9mr768331fga.66.1219907767561;
        Thu, 28 Aug 2008 00:16:07 -0700 (PDT)
Received: by 10.86.30.20 with HTTP; Thu, 28 Aug 2008 00:16:07 -0700 (PDT)
In-Reply-To: <7v8wuim4kv.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/28/08, Junio C Hamano <gitster@pobox.com> wrote:
>  This may be repeating what Jeff said earlier in another thread, but I
>  think we should rethink the start-up sequence carefully.  Ideally (I am
>  thinking aloud)...
>
>   * Have a single function "git_setup()" that notices --bare and --git-dir
>    from the command line and GIT_DIR environment, and does the discovery
>    of git_dir (if not told with the command line or environment
>    explicitly); if we do not find it, do *NOT* barf.  Just record the
>    facts it finds somewhere (e.g. the location of git_dir, absense of
>    git_dir, if the repository is explicitly bare, etc.).
>
>   * As the next step, still in this single function, if we have git_dir,
>    find out where the work_tree is, paying attention to --work-tree from
>    the command line and GIT_WORK_TREE environment if exists.  If we do not
>    have work tree, do *NOT* barf.  Again, just record the facts it finds.
>    If we do not have --work-tree from the command line and if we are not
>    told that it is --bare from the command line, then we may need to open
>    the config to see where core.worktree points at.

Part of worktree issues comes from the fact that worktree setup is
spread over many functions, starting at setup_git_dir*() and ending at
setup_work_tree().
So setting it up in a single function and turning setup_work_tree()
into "check and die()" logic sounds great.
-- 
Duy
