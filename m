From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Installing on AIX fails
Date: Fri, 4 Jun 2010 11:13:45 +0200
Message-ID: <AANLkTik_FI0CETWZZcu8O8MQQx5oV6YAbt5-X0ozbVmw@mail.gmail.com>
References: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Dario Rodriguez <soft.d4rio@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 11:13:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKSyP-0006pJ-F7
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 11:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096Ab0FDJNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 05:13:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:56696 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913Ab0FDJNr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 05:13:47 -0400
Received: by fg-out-1718.google.com with SMTP id l26so59902fgb.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 02:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=F7FQe3MT6WkEM+ZfySg0PzfBITo2U+F1x+xxHWuY9yI=;
        b=tvZX0TLWkstfS1ML6tPBeb2AjTYFu3zAcMHl3M6kOKBppBkz+GLNQtbBnFfOvKSpM/
         j538p6v17EacvYC8iLf/aJAClS//Nj/PR+hLyZ2tM1ikKS7BkjceEcdROEkI2swXAjO0
         c3MLQDNljOnXngx7duRKSj+e39AU1ODd9/RLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=S+D4LxJK5lES1HL9Det8h4H/zovi0keCday68ZEZz2IJbTJTw9yEj+ZdSR20OTQ17b
         8R2DDZKRiahAICT7S0d/uneDb6p3pWTVCbKbIlvhdQYk8l4GYLEfsrhuhKWc9v+yeQfa
         AWk4ElLq3Y89u56A9jym1Moe0GQuy0cOLyvSk=
Received: by 10.239.184.6 with SMTP id w6mr703822hbg.5.1275642825808; Fri, 04 
	Jun 2010 02:13:45 -0700 (PDT)
Received: by 10.239.156.209 with HTTP; Fri, 4 Jun 2010 02:13:45 -0700 (PDT)
In-Reply-To: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
X-Google-Sender-Auth: T-lLW7sgzLO_Lt5N-WPGCBv41vA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148390>

Re. building on AIX.

For AIX I've found that it's just better to always rely on the
freeware toolkit stuff, which comes on a separate toolkit CD and in
any case can be downloaded from
ftp://ftp.software.ibm.com:/aix/freeSoftware/aixtoolbox/RPMS/ppc
These are RPMs that you install via RPM which comes pre-installed on
AIX (or anyway is part of the standard AIX CDs).

On my own build the make, install, tar (gtar), grep, come from the
toolkit CD (the /usr/freeware/bin/ path). At least the first two seems
definitely mandatory.
Oh, and AIX /bin/sh is not particularly good - it's simpler to rely on
bash from the toolkit.

Depending on your AIX and compiler versions you may need some
additional changes. Gary Vaughan have posted patches which include
updates that will improve the AIX experience. In addition to that, if
you have the old XlC 5.0 compiler you will probably be better off at
this point to use gcc from the toolkit. Otherwise you'll need those
patches, and also one I posted which removes some C++ comments (I
should probably re-post that one because it's not against the latest
git repo version anymore).

All that been said, I build on AIX as follows, using configure (which
takes care of some other issues at the moment).

SHELL_PATH=/opt/freeware/bin/bash
PERL_PATH=/usr/local/special/bin/perl ./configure CC=cc
CFLAGS=-Dinline=""
and
make SHELL_PATH=/opt/freeware/bin/bash PERL_PATH=/usr/local/special/bin/perl
followed by the same, with 'install'

That's with the old compiler and patches applied. Without patches
you'll either have to rely on GCC (and remove those CC and CFLAGS
lines, or change CC to gcc), or, with a newer (say, v10) IBM
compiler), the -Dinline="" may not be needed.

The only problem now is that some stuff (git rebase --interactive
IIRC) will still not work, if you're on an AIX version with Perl 5.6
(some things in git needs 5.8). AIX 6.1 has Perl 5.8, but some
customers will downgrade to 5.6 because of bad performance problems
with 5.8 on AIX.

-Tor
