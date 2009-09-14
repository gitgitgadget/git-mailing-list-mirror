From: Alexey Borzenkov <snaury@gmail.com>
Subject: Re: [msysGit] [PATCH 06/17] mingw.c: Use the O_BINARY flag to open 
	files
Date: Mon, 14 Sep 2009 23:06:14 +0400
Message-ID: <e2480c70909141206r3618a291l7317696bdc98b4fb@mail.gmail.com>
References: <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com>
	 <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com>
	 <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com>
	 <baa73a58d459d9cd29227b1f0fb02306c14db807.1252925290.git.mstormo@gmail.com>
	 <cover.1252925290.git.mstormo@gmail.com>
	 <54b586ed58d1e9b4204658871f6f34453b48758b.1252925290.git.mstormo@gmail.com>
	 <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 21:06:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnGsX-0000qa-Mu
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 21:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756820AbZINTGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 15:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756817AbZINTGM
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 15:06:12 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:62536 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756814AbZINTGM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 15:06:12 -0400
Received: by fxm17 with SMTP id 17so1069409fxm.37
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=r06iwwDRDOZee7EU3vL1ZuU5qr2RBULz1xBq9DiQqaE=;
        b=MIZ7E/O6htFd/xLL0s6p/BuJA0zd68yg9PMYK7Pbfu4GHZf8hyp/CcOs/WeqsfBADs
         e2wnXlMzbSm3Mb0AJ0TaEU07P/vK+/5XfV4PZNe8+fnktVSRo1vfHgtux8boosBSfBtX
         Q0fk4X1Z8fY8LLrmlGpqaTtBnzzdZjb8x6+eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=f8wVvtKAqJQ0KUgZD7tm/mHbg9t3pf31+9hAsz4jQQdYoJHKF3HVdVl+YpedMIUU/d
         6X196feZ1TLBuxodGQJubxBXjH4n9L1SRgT9Z0oHgYq625ngdGYzd6d77MkWpzSLn9Pa
         99lFbAJmozlrLJP2PbrgV4IcVP8MTpqAop4YI=
Received: by 10.223.144.82 with SMTP id y18mr2359744fau.74.1252955174158; Mon, 
	14 Sep 2009 12:06:14 -0700 (PDT)
In-Reply-To: <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128491>

On Mon, Sep 14, 2009 at 5:11 PM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
> On Windows, binary files must be opened using the O_BINARY flag for
> untranslated mode. MinGW does this for us automatically, but Microsoft
> Visual C++ does not.

Wouldn't it be better to set explicitly set _fmode = _O_BINARY when
_MSC_VER is defined? _CRT_fmode is mingw specific, that in addition to
setting _fmode also sets mode on stdin/stdout/stderr (see
http://www.koders.com/c/fid2B507DE94598397757D615EDF52267578AD838A2.aspx).
Current patch will not set binary mode for files opened with fopen, as
well as stdin/stdout/stderr. One catch might be that declaring it like
"unsigned int _fmode = _O_BINARY" might not work, it seems that you
are supposed to set it somewhere in the code (see
http://msdn.microsoft.com/en-us/library/ee2849wt(VS.80).aspx). Perhaps
implementing a function like _mingw32_init_fmode in crc1.c in
mingw-runtime and calling it early in main() would be better?

Thanks,
Alexey.
