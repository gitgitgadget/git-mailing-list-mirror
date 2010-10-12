From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Push not writing to standard error
Date: Tue, 12 Oct 2010 14:21:17 -0500
Message-ID: <20101012192117.GD16237@burratino>
References: <AANLkTim6j7cXj2-1JnKdNLb8KFJK86F02tzeByDBskEa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Chase Brammer <cbrammer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 21:24:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5kSs-0006I0-Vr
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 21:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758130Ab0JLTYk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Oct 2010 15:24:40 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:35484 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989Ab0JLTYk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 15:24:40 -0400
Received: by qyk5 with SMTP id 5so819908qyk.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6FlthA6/rVl8q5fbCBmRadQJ9PiQuWQ273KfIqFH5Pk=;
        b=ului4HYe7W7Ri4hJ0YlKdqHawe5CegYhW1GLJk6wrp5/juqWbBAvkzI7KWVkfH7M4N
         CU3y6DeZeiSw8ekDkl4Ht4x6bmvtNYjsaOPc6SHQKQAqJWbHp+5nxsKS4dEDH4ml10b9
         gLtuvDYuNymy8wonws5zj6tfvyodO/lDVKsOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Unvg+A9rce4LDJDBRSzemIWUiCJLGbFQr9JXhzUjZMEIFWyYBQY4YFNwRG7jkxANHm
         E1yqzlz0Gw81s8Urw81tliKkj2cB2TTGhHLgSU3E06OvxnEzRkDnOwIQtj8rv2DcTSNN
         r1Cijm0GwZx8iLFyXfq0lH6gocMP8spF4Y/t4=
Received: by 10.224.66.29 with SMTP id l29mr5988779qai.239.1286911479130;
        Tue, 12 Oct 2010 12:24:39 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id nb14sm6505990qcb.12.2010.10.12.12.24.35
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 12:24:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim6j7cXj2-1JnKdNLb8KFJK86F02tzeByDBskEa@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158870>

Chase Brammer wrote:

>                                    saving the standard error from bas=
h
> to a file during a push doesn't seem to be working. =C2=A0I am only a=
ble to
> get standard output, which doesn't give the progress of the push
> (counting, delta, compressing, and writing status).
[...]
> git push origin master --progress > ~/push_error_output.txt 2>&1
[...]
> Idea's on work arounds or upcoming patches to fix this?

None from me.  But some hints for a patch:

 - As the man page says,

   --progress

	Progress status is reported on the standard error stream
	by default when it is attached to a terminal, unless -q is
	specified. This flag forces progress status even if the
	standard error stream is not directed to a terminal.

   It looks like this facility is not working.

 - Terminals are distinguished from nonterminals with isatty()

 - The "Counting objects..." output comes from pack-objects.
   Running with GIT_TRACE=3D1 reveals that the --progress option is
   not being passed to pack-objects as it should be.

 - Is this a regression?  If so, narrowing the regression window
   with a few rounds of "git bisect" could be helpful.

Thanks for the report.
