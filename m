From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Better chopping in commit search results
Date: Sun, 24 Feb 2008 00:36:01 +0100
Message-ID: <200802240036.02406.jnareb@gmail.com>
References: <7vbq6kprql.fsf@gitster.siamese.dyndns.org> <200802222014.13205.jnareb@gmail.com> <7vd4qn1ga2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 00:36:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT3vE-0005fM-Hu
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbYBWXgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 18:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752904AbYBWXgL
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 18:36:11 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:62276 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbYBWXgK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 18:36:10 -0500
Received: by py-out-1112.google.com with SMTP id u52so1612313pyb.10
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 15:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=9g/PxG5bI97N/Z/YlP1VSacTMoYLxere4GjaOCNP8ss=;
        b=GH3wP3paO4hB1o9hrdUHgXO7cHc5WM2RHz7ieV6nsW2JGm7fStsar/JyhdA/q9HsLn9knhNVummjdEhCVbrakcdDEajXDwDdq5zjnsU9Ksp/geL9yTKpsVBrwxcXGE61f5/gCovALxsloB5OXjmjMn5E2LLPYaQSLYK2or9zR8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tqVgoHU4mIy/CUyklFh9hWo4jBuOkmmKfgSYWggXD4d9O4yu+DzIVzkJo28KMuebO/XAYGFWA8mcdYCHxauCnoMNv2M8UAn9OsMk7e2X1oBFPIKqtbh0tQwsEtTm5Y1NIMk27f7o9Zp9pzwUDMD3vtG34j0HZ53/2Ur3U5+3e6k=
Received: by 10.65.158.9 with SMTP id k9mr2200391qbo.41.1203809768986;
        Sat, 23 Feb 2008 15:36:08 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.83])
        by mx.google.com with ESMTPS id h6sm721736nfh.30.2008.02.23.15.36.06
        (version=SSLv3 cipher=OTHER);
        Sat, 23 Feb 2008 15:36:07 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vd4qn1ga2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74882>

On Sat, 23 Feb 2008, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > 	# regexps: ending and beginning with word part up to $add_len
> > 	my $endre = qr/.{0,$len}[^ \/\-_:\.@]{0,$add_len}/;
> > 	my $begre = qr/[^ \/\-_:\.@]{0,$add_len}.{0,$len}/;
> 
> I have no idea what these line noise characters inside [] are.
> Did you mean something like "\w"?

They were in original chop_str, written by Kay Sievers if I have
checked correctly, I have only repeated it. But changing it to
"\w" might be a good idea.

> I have a suspicion that it may be easier to read and could be
> even more efficient to split an overlong line at word boundaries
> and to remove elements from the end you are removing from until
> it fits.
> 
> sub chop_whence {
> 	my ($line, $max, $slop, $where) = @_;

IMHO it is neither easier to read, nor more efficient. And changes
semantic a bit.


Original chop_str used to mean:

 chop_str($str, $len, $add_len) means: Try to chop on a word boundary 
 between position $len and $len+$add_len. If there is no word boundary
 between $len and $len+$add_len, chop at $add_len, and replace chopped
 part by " ...". Do not chop if to be replaced part is shorter than
 ellipsis, i.e. " ..." replacement.

(I think I add this description to gitweb). With this description the 
code is I think quite obvious.
-- 
Jakub Narebski
Poland
