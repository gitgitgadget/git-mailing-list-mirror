From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import: catch garbage after marks in from/merge
Date: Mon, 2 Apr 2012 10:43:56 -0500
Message-ID: <20120402154356.GD3365@burratino>
References: <20120401225407.GA12127@padd.com>
 <20120401231259.GE20883@burratino>
 <20120402001354.GA12651@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 17:44:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEjQt-00026k-3N
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 17:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab2DBPoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 11:44:09 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62691 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab2DBPoI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 11:44:08 -0400
Received: by gghe5 with SMTP id e5so1259713ggh.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LUPFsacrs0sBzjvaO5qM6i0MYKCQVYMdfGIqyYX6ycU=;
        b=oB1kC4sesWNjcThSXnfq08dKr4z9Z8KptLEKwpc/WBFRTrJUNkHRddhuvFZ0F6gQQa
         CwzXuZ/D7OxQwbtRvt2IdtCr7z+St3Y7sIzuXID0r9KRq9fFm/25pXxOVWrXt0vVPTzY
         NdkokEv1ZMUcOm1jVHDJOsJYjiQJ+rbPzfbGOQA7q06jtpiAcg2WSy/VKpdrg1bmEDlK
         mrV/LQERMmqbXfFkyVLeYfkPDgnd8Pz73DDISRIzpuYI+XDgooZP1XLcO4Gf2oA40EsI
         Vp8IR+5Z3KcsWyylz3W6F4RSiIad3BEEWpGEMA3et0Z3WvfWu8nUXJ7IOdmHNLXQx6EU
         zw/A==
Received: by 10.60.20.100 with SMTP id m4mr13716617oee.10.1333381446628;
        Mon, 02 Apr 2012 08:44:06 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id c6sm14299021oec.13.2012.04.02.08.44.02
        (version=SSLv3 cipher=OTHER);
        Mon, 02 Apr 2012 08:44:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120402001354.GA12651@padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194521>

Pete Wyckoff wrote:
> jrnieder@gmail.com wrote on Sun, 01 Apr 2012 18:12 -0500:

>> Why allow whitespace after the mark number?
>
> Fear of breaking existing fast-import users that might happen
> to have stray whitespace, or \r\n terminators.

Oh.  I think worrying about that sort of thing is a very good thing.
In particular, the possibility of \r\n terminators from an importer
that writes its output in text mode on Windows is somewhat scary.

Luckily such a problem would be caught as soon as the importer uses
a filemodify (M) command:

 - if it quotes the path:

	fatal: Garbage after path in: M ...

 - if it doesn't quote the path, the resulting import would use
   filenames with trailing CRs.

So we narrowly escape that problem.

Other types of stray whitespace at eol seem less likely but it's
probably worth letting a patch like this incubate in the "next" branch
for a little while to see if anyone complains.

The reason to care instead of just being permissive is that git
fast-import is not the only fast-import backend.  The tighter we can
make the parsing without breaking existing frontends, the better the
chance that a frontend that was only tested against git fast-import
will be usable against all other backends, too.

In other words, there are two requirements in tension here
(compatibility with sloppy frontends, compatibility with fussy
backends).  Some day fast-import might want to learn a --permissive
option to reconcile them.  In this particular case being strict
unconditionally seems safe enough.

My only other hint is that as Dmitry mentioned it would be nice to
nice to use the same logic for other places where fast-import parses a
number at the end of a line, so people don't keep on making the same
print vs println mistake and sending new patches to detect it in each
place one at a time.

Sane?

Thanks,
Jonathan
