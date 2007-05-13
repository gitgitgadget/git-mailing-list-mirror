From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: suggestions for gitweb
Date: Sun, 13 May 2007 13:50:04 +0200
Message-ID: <200705131350.04916.jnareb@gmail.com>
References: <20070512205529.GS14859@MichaelsNB> <f25mic$1b1$2@sea.gmane.org> <7vabw9v906.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Niedermayer <michaelni@gmx.at>,
	Petr Baudis <pasky@ucw.cz>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 01:33:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnNZ1-0002hy-JR
	for gcvg-git@gmane.org; Mon, 14 May 2007 01:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758459AbXEMXcl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 19:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758505AbXEMXcl
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 19:32:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:39498 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758456AbXEMXcj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 19:32:39 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1226383uga
        for <git@vger.kernel.org>; Sun, 13 May 2007 16:32:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qyBD2DuRW//HnA2oCZMUfMUAFnZO4HqsBDPIDhTB+Fs3KH0hrqCRC0oPTd1/E20wLgjifNZeApIJLkm6k3Uq32zRRYpSPm+/gX4jo9QHoyGq7Y/hOBikJumCmOSDljjQ/YMtSkjpYV3s3eCfOtZASfC2j5zzoqmnfDhqVc9NCDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Sn/KRJhhEuyfG7GadoP5/31Zspy8+LKZPq1PRToxnYI/KAyoeucpPJZIeST7b8fIV/p7sNY78tD7eL8XACP+jeQ1w3BTQQ0Oe0uesET6I0OYagK5naVfA8zB+xktQr6v2UPC3YOb4ATpXyAqZe7Bo0nRR5Qq+NuAG8onFKhwyOg=
Received: by 10.67.25.9 with SMTP id c9mr4776194ugj.1179099158392;
        Sun, 13 May 2007 16:32:38 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e33sm12678053ugd.2007.05.13.16.32.36;
        Sun, 13 May 2007 16:32:37 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vabw9v906.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47190>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Lines of code and file sizes: file size needs additional invocation
>> per each file for gitweb; it would be easier for cgit. Costly!
>> Counting LOC is even more costly: take note that 1.) gitweb operates
>> directly on repository / object database, and does not use working
>> area, 2.) git is snapshot based and not changeset based.
> 
> We earlier discussed to make --numstat to allow us add this kind
> of information for easier script consumption.
> 
> Perhaps instead of modifying --numstat, we may be better off to
> add another format that can be more easily extended to support
> other things, like we do for the --porcelain format out of
> git-blame?  It does not have to be one line per record, like the
> way --numstat was done, which was primarily in order to make it
> a compact, human readable format.

Even if we extend --numstat or add yet another diff format meant for
porcelain[*1*], and optionally add similar extension to git-ls-tree
(as I think object size and LOC of file should be placed there), and
the cost of additional fork and exec is not an issue, such extra 
information be still costly in terms of performance: CPU and I/O.

Currently for difftree (whatchanged-like) we need only to compare
trees. For lines added / lines removed statistics we need to _generate_ 
diff.

For file size (object size) we need at least find the object in question 
and read it's header; for lines of code we need to get blob contents
(find object, uncompress, optionally undeltify) and count the lines.

Its not insurmountable: we can use %feature for that, like in the case
of other CPU-intensive features like 'blame' or 'pickaxe', or 
high-bandwidth features like 'snapshot'.


Footnotes:
----------
[*1*] What we should name it? --numstat-extended, --machinestat,
--porcelain, --allstat, <insert your own idea here>?

-- 
Jakub Narebski
Poland
