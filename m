From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 2/2] Don't touch ref files manually
Date: Tue, 21 Aug 2007 17:58:45 +0200
Message-ID: <20070821155845.GA16221@diana.vm.bytemark.co.uk>
References: <20070810031949.19791.54562.stgit@yoghurt> <20070810032318.19791.70483.stgit@yoghurt> <b0943d9e0708210623h112faa42p97bba06bc9fab774@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org,
	Yann Dirson <ydirson@altern.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 17:59:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INW8k-00006F-9L
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 17:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759317AbXHUP7L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 21 Aug 2007 11:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759054AbXHUP7K
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 11:59:10 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1257 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758169AbXHUP7J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 11:59:09 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1INW7x-0004Gc-00; Tue, 21 Aug 2007 16:58:45 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0708210623h112faa42p97bba06bc9fab774@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56302>

On 2007-08-21 14:23:29 +0100, Catalin Marinas wrote:

> On 10/08/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > Messing with files manually doesn't work if the refs are packed.
> > The officially preferred way is to use git-update-ref,
> > git-show-ref, et.al. So do that.
>
> Thanks for this patch. I'll apply it but I have some questions
> below.
>
> > @@ -294,14 +301,16 @@ def set_head_file(ref):
> >      # head cache flushing is needed since we might have a differen=
t value
> >      # in the new head
> >      __clear_head_cache()
> > -    if __run('git-symbolic-ref HEAD',
> > -             [os.path.join('refs', 'heads', ref)]) !=3D 0:
> > +    if __run('git-symbolic-ref HEAD', ['refs/heads/%s' % ref]) !=3D=
 0:
> >          raise GitException, 'Could not set head to "%s"' % ref
>
> Why replacing os.path.join with a single string? I think the former
> is more portable if, in the future, someone will try to run StGIT on
> Windows (and GIT would be compiled directly, without cygwin).

Yes, that's the case iff it is a pathname in the file system. But I
think forward slashes are used even on Windows in this case --
otherwise too mmuch configuration would have to be changed. This is
what I _think_, however; I haven't actually checked.

> > diff --git a/t/t1000-branch-create.sh b/t/t1000-branch-create.sh
> > index cca5504..e920e93 100755
> > --- a/t/t1000-branch-create.sh
> > +++ b/t/t1000-branch-create.sh
> > @@ -13,26 +13,9 @@ Exercises the "stg branch" commands.
> >  stg init
> >
> >  test_expect_success \
> > -    'Create a spurious refs/patches/ entry' '
> > -    find .git -name foo | xargs rm -rf &&
> > -    touch .git/refs/patches/foo
>
> I haven't tried this test but is there any problem if we keep them?

Yes.

This test started to fail after my change. I don't remember exactly,
but I think it was git-symbolic-ref actually reading the file, finding
no ref there, and ignoring it. So this empty file didn't mess up the
machinery anymore, and since this isn't a common usecase anyway, and
since this change is to rely on git for all the low-level ref
manipulation, I just deleted the test.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
