From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC/WIP/POC] git-gui: grep prototype
Date: Sun, 14 Nov 2010 16:09:32 -0600
Message-ID: <20101114220932.GE16413@burratino>
References: <1289770869-11665-1-git-send-email-bert.wesarg@googlemail.com>
 <20101114215442.GC16413@burratino>
 <AANLkTiktg4aZ7VfdXUT9XF4RK7MuCvzevB5jSRaNiE1L@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	"Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 23:10:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHkm7-0005zq-8q
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 23:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755749Ab0KNWKJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 17:10:09 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50069 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab0KNWKI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 17:10:08 -0500
Received: by ywc21 with SMTP id 21so1425209ywc.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 14:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mlsVmKnORcDlzdvvk2l4PvoIKv3qQcTwb2pQDd8o86I=;
        b=Z8S3RjhAo4rciLNpT6tyIQE4iwjULR7SECQLWbjbKZXhZd8b+Oef1ygKryFcvdqkJb
         x1Rn/Br37BB5d9R07RvKgG+6oegXKcg5tJKCqPLETTtXMYPjQAk7w/eLA9ds+IPrjnEo
         on0WUYW5i4Y9NQC5glG4aYPfZckNqOpGXa1zg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=K1Qka8JleaKJ/tmwJdZxmD95wQbWLqhQ3KAxuRXx2vyAfYF8fbaWVJ8FXWH0aS2khe
         AWO569vYp1uRjJkfU6LqXg+vOGiZackFw3c58R1HaU9u/tCU4EL76mkoUIrNv1jpwtaG
         pIrG5wGgB6yBRIX/1yPdZkAXPxYdJ1nmrMueg=
Received: by 10.101.68.8 with SMTP id v8mr3712926ank.98.1289772607302;
        Sun, 14 Nov 2010 14:10:07 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id c39sm2969912anc.1.2010.11.14.14.10.05
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 14:10:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTiktg4aZ7VfdXUT9XF4RK7MuCvzevB5jSRaNiE1L@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161456>

Bert Wesarg wrote:
> On Sun, Nov 14, 2010 at 22:54, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> This sounds like an excellent sort of thing to add to git grep -O, t=
oo
>> (which currently has very limited support for editors' line number
>> features). =C2=A0But what will it do with typical non-git-specific s=
etups
>> like
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0VISUAL=3Dvim
>>
>> or
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0EDITOR=3D"gvim --nofork"
>>
>> ?
>>
>> Do existing editors support LINENUMBER in the environment?
>
> I don't expect this, I have a wrapper script around my editor to scan
> the environment for these variables and pass the block/non-block
> option to the editor.

In that case, perhaps something like

	GIT_EDITOR=3D$(git var GIT_EDITOR)
	set -- --open-file-named-in-the-environment
	eval "$GIT_EDITOR" '"$@"'=20

would be appropriate?  This way, existing editors like vi, ed, and
emacs fail:

	$ ed --fjdkaslfjdas
	ed: unrecognized option `--fjdkaslfjdas'

rather than opening a new, empty file.
