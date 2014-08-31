From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: git fsck exit code?
Date: Sun, 31 Aug 2014 20:54:05 +0200
Message-ID: <CAA787rmf7aNJ+ErXk6Lc_hLVDxMV8s2Lx_YmZud83yia4n0VKA@mail.gmail.com>
References: <1409177412.15185.3.camel@leckie>
	<20140829185325.GC29456@peff.net>
	<xmqqha0v5cgn.fsf@gitster.dls.corp.google.com>
	<1409343480.19256.2.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 20:54:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOAGe-00058h-CI
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 20:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbaHaSyJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Aug 2014 14:54:09 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:59873 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbaHaSyH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Aug 2014 14:54:07 -0400
Received: by mail-lb0-f182.google.com with SMTP id u10so4951020lbd.27
        for <git@vger.kernel.org>; Sun, 31 Aug 2014 11:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=QX3610WXTgflRJsRjxtN6JfpW3NrnEpWDI1FBi2sA4g=;
        b=fLk/XAejhkzO6vJkJ3GKSNCjidndOEzrXRuAyHFUzR/mlTAiuJZIkI7DoHW8k9YMpq
         iYq68Kg3Gk26JQXj9vJlGAUsr+98qWiRi/YTCnzXMl1rraH+MivhNEet40qDuh/w2TKn
         DfV/APZ4tiQCmKZAQxCjouhc/QQ/0BEBlmySlmPXJRZob8aA4EeqL72nk1lDJKlV/fwE
         +9LNhUZNvv51BUN6qJlZjE3ZGtN3hDT/CqZyvJmaVmBJCkDaAyYQ7hWpdPhy5/hTZ3qo
         9dQ73v7f1z31Z5MEjl391fEXKqfEW9Kd5lyRgIY7NXYAZXjxMi2h0ko2zxZ63OykIbg/
         6ZeA==
X-Received: by 10.112.148.133 with SMTP id ts5mr23021611lbb.45.1409511245289;
 Sun, 31 Aug 2014 11:54:05 -0700 (PDT)
Received: by 10.112.140.73 with HTTP; Sun, 31 Aug 2014 11:54:05 -0700 (PDT)
In-Reply-To: <1409343480.19256.2.camel@leckie>
X-Google-Sender-Auth: ydJaa9FpJBHwalagggxP2uR-Ad8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256295>

On 29 August 2014 22:18, David Turner <dturner@twopensource.com> wrote:
> On Fri, 2014-08-29 at 12:21 -0700, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> > > On Wed, Aug 27, 2014 at 06:10:12PM -0400, David Turner wrote:
> > > > It looks like git fsck exits with 0 status even if there are
> > > > some errors. The only case where there's a non-zero exit code i=
s
> > > > if verify_pack reports errors -- but not e.g. fsck_object_dir.
> > >
> > > It will also bail non-zero with _certain_ tree errors that cause
> > > git to die() rather than fscking more completely.
> >
> > Even if git does not die, whenever it says broken link, missing
> > object, or object corrupt, we set errors_found and that variable
> > affects the exit status of fsck.  What does "some errors" exactly
> > mean in the original report?  Dangling objects are *not* errors and
> > should not cause fsck to report an error with its exit status.
>
> error in tree 9f50addba2b4e9e928d9c6a7056bdf71b36fba90: contains
> duplicate file entries

I don't think git fsck should return !0 in this case. Yes, it's an
inconsistency in the repo, but it's sometimes due to erroneous
conversions from another SCM or some other (non-standard) implementatio=
n
of the git client. I've seen things like this (and other inconsistencie=
s
in repos, like wrong date formats, non-standard Author fields, unsorted
trees, zero-padded file modes and so on), and the thing is, owners of
public repos with these errors tend to avoid fixing it because it
changes the commit SHAs. If git fsck starts to return !0 on these
errors, it will always return error on that repo, which in practise
means that the error code is rendered useless. IMHO git fsck should onl=
y
return !0 on errors that can be fixed without changing the commit
history, for example missing or invalid objects.

=C3=98yvind
