From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] guilt: Make sure the commit time is increasing
Date: Tue, 6 Jul 2010 03:03:22 -0500
Message-ID: <20100706080322.GA2856@burratino>
References: <1278296639-25024-1-git-send-email-tytso@mit.edu>
 <20100705025900.GQ22659@josefsipek.net>
 <67D0ABD4-BD1A-4B7A-B3EC-F48F21B5DD01@mit.edu>
 <20100705185238.GS22659@josefsipek.net>
 <20100705192201.GI25518@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jeffpc@josefsipek.net, Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Tue Jul 06 10:04:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW38i-00050f-SM
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 10:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898Ab0GFIEH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 04:04:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63891 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab0GFIEF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 04:04:05 -0400
Received: by iwn7 with SMTP id 7so6391869iwn.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 01:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4653JcYKpIcdWlNLVelIMma1am+PLl2fzejhwcZiW2c=;
        b=aP7TQwxfxQ+LbJuIDaNzMDoNrdt+OrDwCwBcD3X4moPzNYtHYXjp/ihbinKrBeEe6o
         a/lxVwIcTJjxpf1CxF9cGAy7QEjNUtcp9fX03d20EHFo/2OGQpej8nuAbWHEz3inK06U
         3zdo3IL3RkOvnuaCOyduiOV1iEjAHyIAS5kO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=yCQlniryt7GG1IyfeKvYjMq07eGmRi/ykMkCb4QA/GJseUbN2wMQg7I3b+0k1MOKz3
         MXMTZkW2pd07p7z9ZmU9B4Wz/JItXDJ/GOUpDBYfXg2It5JquKO4nSqxmJsW4ojEAaBs
         YTtTT7vk8W0shzn7Upms0x2eiQGJrjaM0YNzY=
Received: by 10.231.35.10 with SMTP id n10mr4197370ibd.137.1278403441940;
        Tue, 06 Jul 2010 01:04:01 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm22389789ibi.6.2010.07.06.01.04.01
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 01:04:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100705192201.GI25518@thunk.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150334>

tytso@mit.edu wrote:
> On Mon, Jul 05, 2010 at 02:52:38PM -0400, jeffpc@josefsipek.net wrote=
:

>> if I commit, and immediately after push 10 patches, wouldn't the HEA=
D end up
>> with a commit that's ~10 minutes in the future?

I don=E2=80=99t think git has ever required commit dates to be _strictl=
y_
monotonic.

At one point rev-list did require monotonic --- i.e., the committer
date of each commit had to be equal to or later than that of each of
its parents) with no clock skew but that was considered a bug and
fixed by v1.5.5-rc1~16 (Make revision limiting more robust against
occasional bad commit dates, 2008-03-17)

> diff --git a/guilt b/guilt
> index b6e2a6c..edcfb34 100755
> --- a/guilt
> +++ b/guilt
> @@ -535,6 +535,17 @@ commit()
>                          export GIT_AUTHOR_EMAIL=3D"`echo $author_str=
 | sed -e 's/[^<]*//'`"
>  		fi
> =20
> +		ct=3D$(git log -1 --pretty=3D%ct)
> +		if [ $ct -gt $(stat -c %Y "$p") ]; then
> +		    echo "Adjusting mod time of" $(basename "$p")
> +		    ct=3D$(expr $ct + 60)
> +		    if [ $ct -gt $(date +%s) ]; then
> +			touch "$p"
> +		    else
> +			touch -d @$(expr $ct + 60) "$p"

So I would suggest

 echo "Adjusting mod time of $(basename "$p")"
 touch -d "$ct" "$p"

If the parent commit time happens to be in the future, well, at
least we=E2=80=99re not making it worse.

By the way, I think your idea to have commit warn about nonmonotonic
commit dates is a good one.  We should also decide on a rule,
hopefully one the kernel repo obeys (30 days max skew? *crosses
fingers*) and make git fsck warn loudly about violations.
