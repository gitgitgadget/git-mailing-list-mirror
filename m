From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH] Implement a new patch identification scheme and id command
Date: Mon, 16 Jun 2008 11:00:22 +0100
Message-ID: <b0943d9e0806160300q55dde16fg90de0fa12e3d5dc0@mail.gmail.com>
References: <20080614072833.7899.91460.stgit@localhost.localdomain>
	 <20080614094714.GC14282@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 12:01:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8BWZ-0000av-5N
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 12:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbYFPKAZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jun 2008 06:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755257AbYFPKAZ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 06:00:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:15766 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbYFPKAX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2008 06:00:23 -0400
Received: by wa-out-1112.google.com with SMTP id j37so4283830waf.23
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 03:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=DcAbGTMHDN7OibRZLYzR5JZ/fpQUdBeiEwSjUitjSRw=;
        b=XXGzm2TEbLbornd+nlDxn7E4FBtcVdowWZnONcmErzHIvff1SBbNhkM9I/g+HpjDWm
         R58EpHeO0VJ4kexYMzC9QJDKAJzalz/oo8/u9+e/GgeWpsOhCjX1F/sVKWWM3lqSak6W
         yshKmT9w3RIbojDvV0RJgSH6y1S2Tr6KXsIU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PR3ZDMQ6SObQgiUCxDVoy6D4u+l3Au9PxMLICe8bJKvMlHNC8/mqlK5Eib5lvmDXJw
         GWvt63OEkTX5AQ5zVMcVVuaKLihVArtYMAxPuL3nEuvZh/M4zCR1Vkcb2qaoU8GDxFzj
         6WlKV4AS6nsyBMmnexFMwXtrcFWM2F+9lX6G0=
Received: by 10.114.193.1 with SMTP id q1mr5871402waf.70.1213610422256;
        Mon, 16 Jun 2008 03:00:22 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Mon, 16 Jun 2008 03:00:22 -0700 (PDT)
In-Reply-To: <20080614094714.GC14282@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85171>

2008/6/14 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-14 08:28:33 +0100, Catalin Marinas wrote:
>
>> The new scheme allows '[<branch>:]<patch>' and '[<branch>:]{base}'
>> (the latter showing the base of a stack). The former format allows
>> symbols like ^, ^{...} etc.
>
> I like your choices.

I think the initial idea belongs to Yann.

>> +def git_sha1(repository, branch, name):
>> +    """Return the SHA1 value if 'name' is a patch name or Git commi=
t.
>> +    The patch names allowed are in the form '<branch>:<patch>' and =
can be
>> +    followed by standard symbols used by git-rev-parse. If <patch> =
is '{base}',
>> +    it represents the bottom of the stack.
>> +    """
>
> Why not return the Commit directly, and let the caller extract its
> sha1 if that's what it wants?

OK, I was thinking about that. I'll convert it to git_commit(...) and
return a commit since I think it's only "stg id" that needs the SHA1
value.

> You don't remove the old parse_rev() and git_id(), and particularly
> the latter has a lot of callers. Meaning that the rest of StGit still
> speaks the old syntax.

I thought about removing them when we convert the commands to the new
infrastructure. In the meantime, I can rewrite git_id to use
git_commit directly. The parse_rev is only used by the 'pick' command
(and git_id). I'll have a look at these functions.

>> +    # Try a Git commit first
>> +    try:
>> +        return repository.rev_parse(name, discard_stderr =3D True).=
sha1
>> +    except libgit.RepositoryException:
>> +        pass
>
> What if you have a branch or tag with the same name as a patch? This
> will prefer the branch, which might not be the best choice.

I can swap them and have the patch as preferred. People can be more
precise if they want the branch or tag by passing heads/... or
tags/...

>> -directory =3D DirectoryHasRepository()
>> +directory =3D common.DirectoryHasRepositoryLib()
>>  options =3D [make_option('-b', '--branch',
>>                         help =3D 'use BRANCH instead of the default =
one')]
>
> Couldn't we kill this option? (And in the process, the branch argumen=
t
> to git_sha1.)

No problem with the option but I would like to keep the branch
argument to git_sha1. There might be cases where it is used like
picking multiple patches and I only specify one -B option to 'pick'. I
don't want to build the qualified patch name for every patch. I can
change the prototype of git_sha1 though (to git_commit):

def git_commit(name, repository, branch =3D None):

and branch needs to be passed explicitly and used instead of the
default one (when the patch name doesn't contain any).

>> -test_expect_success 'Try new form of id with slashy branch' \
>> +test_expect_success 'Try new id with slashy branch' \
>
> Strictly speaking, this isn't so new anymore.

The id format is new.

--=20
Catalin
