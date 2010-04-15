From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: failed to lock
Date: Thu, 15 Apr 2010 00:00:37 -0400
Message-ID: <k2x76718491004142100v6e1ece6djc62aa540e51eed5@mail.gmail.com>
References: <j2o76718491004141349l53b53347v7f4c0edcab69e4c2@mail.gmail.com>
	 <t2i76718491004141402h33bb2044g155ef1715c63904e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 15 06:00:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2GFw-0005f4-Vf
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 06:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923Ab0DOEAj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Apr 2010 00:00:39 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33088 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab0DOEAi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 00:00:38 -0400
Received: by vws5 with SMTP id 5so39323vws.19
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 21:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FCc62pTBh4bubI5/jTTMyTB3sH8AwAHlr1sjSVC0UsM=;
        b=tiWFnV3SIwuHV+Qqe6Jg9d1gL6yYqa+njeoWCd+d8CxME8TQuG1zmtQQ/78GVNGTcd
         y2+fFJxYBWfOta9DwjHVKV8XLuxMhVuwa9bAly4xhJfRcUBhKKQVukuwKXqE53F6w1vt
         tWIL4zE488WaAEO0tGuHatpBfOc+K6MB79JSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sLMxDqDW98cTTc8lDgM98H7taQmCV6bq2s8250rXW4oyR0u930GfPGattiLI7ziImI
         C9q0umwWLOkEnsYO1DpgoyUXjenA6h5D+C1X8n6TplJWGQV+crScHwGFeC6rNSo2triu
         50lKOjYUJVArCwglXPH68vTpAm+YOCeBh+/PM=
Received: by 10.220.100.195 with HTTP; Wed, 14 Apr 2010 21:00:37 -0700 (PDT)
In-Reply-To: <t2i76718491004141402h33bb2044g155ef1715c63904e@mail.gmail.com>
Received: by 10.220.3.230 with SMTP id 38mr4744946vco.172.1271304037684; Wed, 
	14 Apr 2010 21:00:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144945>

On Wed, Apr 14, 2010 at 5:02 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> Ah, this is the problem:
>
> $ git push mirror
> Total 0 (delta 0), reused 0 (delta 0)
> error: Ref refs/remotes/origin/master is at
> 81358fbe72926d74bdeda85669d655e144572c48 but expected
> 3c0a87afc2e9248890dd6de40b5039bcb48c8516
> remote: error: failed to lock refs/remotes/origin/master
> To ssh://mirror/repo
> =C2=A0 3c0a87a..81358fb =C2=A0origin/HEAD -> origin/HEAD
> =C2=A0! [remote rejected] origin/master -> origin/master (failed to l=
ock)
> error: failed to push some refs to 'ssh://mirror/repo'
>
> The origin/HEAD symref and --mirror do not get along together. Hmm.

Proposal: receive-pack should look through the list of heads it has
received and check whether each is locally a symref. If so, and if the
destination of the symref is also among the list of heads, it should
ignore the symref update.

In the example above, receive-pack would determine that
refs/remotes/origin/HEAD locally is a symref to
refs/remotes/origin/master. Since refs/remotes/origin/master is in the
list of heads, it would ignore the update for
refs/remotes/origin/HEAD.

If that sounds reasonable, I can work on a patch.

In case you're wondering how I got into this situation:

server$ git clone --bare /shared/project.git ~/backup/project.git
client$ git clone server:/shared/project.git
client$ cd project
client$ git remote add --mirror backup server:~/backup/project.git
client$ work, commit, work, commit
client$ git push backup

j.
