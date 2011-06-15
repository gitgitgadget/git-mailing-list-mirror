From: Jiang Xin <worldhello.net@gmail.com>
Subject: Painless namespaces design
Date: Wed, 15 Jun 2011 19:18:21 +0800
Message-ID: <4DF894FD.9040808@gmail.com>
References: <1307487890-3915-1-git-send-email-jamey@minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Wed Jun 15 13:18:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWo7O-0001ax-Nh
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 13:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877Ab1FOLSi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2011 07:18:38 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39961 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab1FOLSh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 07:18:37 -0400
Received: by pvg12 with SMTP id 12so186451pvg.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 04:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=IFVikxOXUUHrnd8+eDT9ZX3TnO7N3/MNS3BoSdnvfls=;
        b=vdQpuNYUX2qIoGXmPwEUgog6/WiJztHYytxhljbatyt03ckskIaluLHXSaKcilf/BS
         m6VUEu5XkU3D/mjit8kJgxw0ZeO6FTSgPtumJ5+511V7xfKPpEdj6Fnl5t2O/hpHrwG2
         +CLZvqYZB8MR75Y1Wrese5GUJ7tbvroXskIJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=vvs1nOwMYGrBgxM8kMAWaa0SPxET9Fv1soAuoK+UxPFgUN4K4PVxQCwTF3auIXI80r
         LS9GYs76oLrTFQcv/v2r6inaM/obZjXIFIHCFz/loKcL+vy2MOAmhp22LVLRjAYsxwCf
         qN4BmtSLORcvXjNmWB7BMU46gj6dam6bV9d94=
Received: by 10.142.117.7 with SMTP id p7mr59288wfc.131.1308136716746;
        Wed, 15 Jun 2011 04:18:36 -0700 (PDT)
Received: from [192.168.0.100] ([123.116.250.130])
        by mx.google.com with ESMTPS id n9sm375525wfk.20.2011.06.15.04.18.26
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 04:18:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; zh-CN; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <1307487890-3915-1-git-send-email-jamey@minilop.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175823>

I like the idea of new namespaces feature from Josh Triplett, Jamey Sha=
rp and others.
I think it is better to pass namespace through remote.remote-name.names=
pace variables,
not through GIT_NAMESPACE environment.

Host1 has a bare repository with multiple namespaces: foo, bar, and foo=
/baz.

* master branch of default namespace : refs/heads/master
* master branch of namespace foo is : refs/namespaces/foo/refs/heads/ma=
ster
* master branch of namesapce bar is : refs/namespaces/bar/refs/heads/ma=
ster
* master branch of namesapce foo/baz is : refs/namespaces/foo/refs/name=
spaces/baz/refs/heads/master

UserA clone namespace foo from Host1:

    $ git clone --namespace foo ssh://Host1/path/to/project.git

the default remote.origin section in  .git/config in userA's working di=
rectory:

    [remote "origin"]
        namespace =3D foo
        fetch =3D +refs/heads/*:refs/remotes/origin/*
        url =3D ssh://Host1/path/to/project.git

When UserA runs `git fetch`, it's just like

    git fetch origin refs/namespaces/foo/refs/heads/*:refs/remotes/orig=
in/*

When UserA runs `git push`, it's just like

    git push origin refs/heads/master:refs/namespaces/foo/refs/heads/ma=
ster

These can be done on the client side, so I think there is no necessary =
to hack
git-receive-pack and git-upload-pack.

Refs of namespace foo/baz not cloned by UserA by default, so name space=
 baz
does not exists in UserA's new cloned repository.

If UserA wants to watch some commits on other namespace in project.git =
in Host1,
UserA can do this:

    $ git remote add --namespace bar  host1bar  ssh://Host1/path/to/pro=
ject.git

Then there is a new remote section in .git/config file in UserA's worki=
ng directory.

    [remote "host1bar"]
        namespace =3D bar
        fetch =3D +refs/heads/*:refs/remotes/host1bar/*
        url =3D ssh://Host1/path/to/project.git

When UserA runs git fetch host1bar, then:

    refs/namespaces/bar/refs/heads/master [remote] =3D> refs/remotes/ho=
st1bar/master [local]

When UserA execute `git ls-remote host1bar`, only show references under=
  refs/namespaces/bar/refs/
of remote Host1.

To mirror all namespaces of project.git in Host1, run this command:

    git clone --mirror ssh://Host1/path/to/project.git


I believe this design is painless for both git server and client side t=
ools.

Topgit is one of my daily use tools. Without namespaces feature, I have=
 to create new repositories
to track develop status. It is because the develop status of a topgit c=
ontrolled repository
is not through one certain branch, but through all the topic branches (=
refs/heads/t/*) and their
base branches (refs/top-bases/t/*).

I'd like to see namespaces feature becomes one part of git.


=D3=DA 11-6-8 =C9=CF=CE=E77:04, Jamey Sharp =D0=B4=B5=C0:
> This series adds support for dividing the refs of a single repository
> into multiple namespaces, each of which can have its own branches, ta=
gs,
> and HEAD. Git can expose each namespace as an independent repository =
to
> pull from and push to, while sharing the object store, and exposing a=
ll
> the refs to operations such as git-gc.
>=20

--=20
Jiang Xin
