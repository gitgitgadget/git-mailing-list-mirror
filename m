From: Guy Rouillier <guyr@burntmail.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Sun, 27 Feb 2011 00:20:41 -0500
Message-ID: <4D69DF29.8030701@burntmail.com>
References: <4D0ED5EC.9020402@burntmail.com> <20101220213654.GA24628@burratino> <4D112586.2060904@Freescale.com> <4D119015.6020207@burntmail.com> <4D2AB63D.7040803@burntmail.com> <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com> <4D2FEF49.8070205@burntmail.com> <20110114074449.GA11175@burratino> <7v8vynnokt.fsf@alter.siamese.dyndns.org> <4D450655.5090501@burntmail.com> <AANLkTik0Mp=Ww_+ZN_jw6t4gsFwLo1UTw5JOpho8bCd=@mail.gmail.com> <7vhbcb35xk.fsf@alter.siamese.dyndns.org> <4D5E1116.7040501@burntmail.com> <7voc69p4xu.fsf@alter.siamese.dyndns.org> <4D5F6E97.4000402@burntmail.com> <7vy65bkw72.fsf@alter.siamese.dyndns.org> <4D61EA4B.3020708@burntmail.com> <7vtyfxgdz2.fsf@alter.siamese.dyndns.org> <7vipwbbrcc.fsf@alter.siamese.dyndns.org> <AANLkTinUtUNGO3NK=JPTqnwcTtPMYjmLw82wJZ5nC
 -32@mail.gmail.com> <4D644FEE.5030004@burntmail.com> <7vaahnbmu2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin@laptop.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 06:22:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtZ59-0003Wz-EI
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 06:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803Ab1B0FV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 00:21:56 -0500
Received: from mx02.burntmail.com ([70.87.63.122]:58745 "EHLO
	mx02.burntmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab1B0FVz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 00:21:55 -0500
Received: from [71.191.145.140] (helo=[192.168.1.60])
	by mx02.burntmail.com with esmtpa (Exim 4.72)
	(envelope-from <guyr@burntmail.com>)
	id 1PtZ3p-00021l-0o; Sat, 26 Feb 2011 23:20:49 -0600
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <7vaahnbmu2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168007>

On 2/23/2011 12:24 AM, Junio C Hamano wrote:
> Guy Rouillier<guyr@burntmail.com>  writes:
>
>> ... Note that this issue is not unique to CVSNT.  What does CVS do
>> with CVSROOT containing a space character?
>
> IIRC, the comparison is done against canonicalized cvsroot string, so
> that you can try to connect to :pserver:Xz.Com:/path/to/repo even
> after you ran "cvs -d :pserver:xz.com:/path/to/repo login" and I
> wouldn't be surprised if the canonicalization involved quoting SP.
> Since August 2009 nobody has complained with the current code that
> doesn't do any canonicalization, and I take that as a sign that
> nobody sane so far used a cvsroot with a space in it ;-).  But that
> doesn't mean nobody sane has been using a cvsroot with an equal sign
> in it, so we would need to at least avoid splitting at an equal sign
> when reading from .cvsroot.
>
> It probably is a good idea to port the cvsroot canonicalization code
> to cvsimport in any case.

As I suspected after reading how the cvspass file is read and written, 
CVSNT doesn't work with repositories with an equal sign in the 
repository name.  You can init it fine, and you can set up a password 
for it.  But if you try to login things go very wrong:

guyr@gentoo-vm /data $ cvs -d 
":pserver:guyr@gentoo-vm:2401:/data/cvs\=repo/cvsroot" login
Logging in to :pserver:guyr@gentoo-vm:2401:/data/cvs\=repo/cvsroot
CVS Password:
Empty password used - try 'cvs login' with a real password
cvs [login aborted]: /data/cvs\=repo/cvsroot: no such repository

I tried as many permutations as I could think of, escaping the equal 
sign, not escaping it, etc.  None of them worked.  I did verify my 
environment before running this test by setting up a repository without 
the equal sign in the name, and everything works fine.

Since CVSNT can't handle a repository with an equal sign in its name, I 
say we don't worry about this.  I say the same about the original CVS 
with a repository name with embedded spaces.  We certainly don't want to 
try to solve problems the original product doesn't solve.

-- 
Guy Rouillier
