From: Michael Lai <myllai@gmail.com>
Subject: Re: [RFC PATCH] git-svn does not support intermediate directories?
Date: Thu, 5 Mar 2009 16:12:27 -0800
Message-ID: <21fc26450903051612u1400b2b4gd71c3eafa4418e37@mail.gmail.com>
References: <21fc26450903031743x4beda8a3i835ecbd428817070@mail.gmail.com>
	 <20090304043019.GC20790@mail.rocksoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Tim Stoakes <tim@stoakes.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 01:14:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfNhQ-0000TR-Ua
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 01:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200AbZCFAMa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 19:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754263AbZCFAMa
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 19:12:30 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:62887 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037AbZCFAM3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 19:12:29 -0500
Received: by rv-out-0506.google.com with SMTP id g37so196390rvb.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 16:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=KUfR57rtiwsv30w/Ime1nohrps0L9fHj9SeoE3lXz2Q=;
        b=o3ZWMBaWx4rmeDrvhC1crHaoCsgLJou+sz2DXb/95YdRxY80pPDqQDwzNsm58N40MW
         Bm/zcyO1iGzqn3yh61CBv2w54kBwk3nVIGNWzKLf7/bn5bxqCNNRzmsGUhKVAWoxDBsc
         FG6RJeB3kZxS+DsSC5Wd6v+JwYqlq3Y9EEIeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Ce/+MHv8lARENm+SisAxCSF3MEkwj7qzfbzxBip9X0Apigfuz+9sKCs5SU3gNHoeQY
         t7QV9+v9Wf7o5FoClPUoWIEALhfTe8DMhYm7yoUxkvwLMf3k/3rb6YUSM0TKYJtHO0ty
         lgJV9vp4yYmlV0awXvDIkjNT3MKZUk540I7Pc=
Received: by 10.141.78.20 with SMTP id f20mr925469rvl.94.1236298347593; Thu, 
	05 Mar 2009 16:12:27 -0800 (PST)
In-Reply-To: <20090304043019.GC20790@mail.rocksoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112361>

I did some additional hacking and may have found a slightly cleaner
way of at least fixing the problems with "git svn fetch".  The problem
with the wrong paths being initialized for branches and tags is fairly
minor (since you can just edit the config by hand), so I'll probably
address that later, if I have time.  Here's the patch (I hope I'm
doing this right):

diff --git a/git-svn.perl b/git-svn.perl
index 959eb52..174f266 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2351,7 +2351,11 @@ sub match_paths {
        if (my $path =3D $paths->{"/$self->{path}"}) {
                return ($path->{action} eq 'D') ? 0 : 1;
        }
-       $self->{path_regex} ||=3D qr/^\/\Q$self->{path}\E\//;
+       my $repos_root =3D $self->ra->{repos_root};
+       my $intermediate_path =3D $self->{url};
+       $intermediate_path =3D~ s#^\Q$repos_root\E(/|$)#\/#;
+       $intermediate_path .=3D '/' if $intermediate_path;
+       $self->{path_regex} ||=3D qr/^\/\Q$intermediate_path$self->{pat=
h}\E\//;
        if (grep /$self->{path_regex}/, keys %$paths) {
                return 1;
        }

--

On Tue, Mar 3, 2009 at 8:30 PM, Tim Stoakes <tim@stoakes.net> wrote:
> Michael Lai(myllai@gmail.com)@030309-17:43:
>> =A0 After spending some hours struggling with git svn, it would appe=
ar
>> that it does not support svn projects stored in paths similar to
>> "http://foo.com/svn/repos/bar/myproject", where "myproject" uses the
>> standard SVN tags/trunk/branches layout. =A0I'm currently using git
>> 1.6.1, though I tried this with 1.6.2-rc2 as well. =A0The resulting
>> .git/config looks something like this:
>>
>> [svn-remote "svn"]
>> =A0 =A0 =A0 url =3D http://foo.com/svn/repos/bar
>> =A0 =A0 =A0 fetch =3D myproject/trunk:refs/remotes/trunk
>> =A0 =A0 =A0 branches =3D bar/myproject/branches/*:refs/remotes/*
>> =A0 =A0 =A0 tags =3D bar/myproject/tags/*:refs/remotes/tags/*
>>
>> Yes, that's a redundant "bar" directory under "branches =3D" and "ta=
gs
>> =3D". =A0The issue seems to lie in git-svn doing something intellige=
nt to
>> extract the appropriate trunk directory. =A0For the branches and tag=
s,
>> however, it just takes the full URL and removes the repository root
>> (http://foo.com/svn/repos/bar) to produce "bar/myproject/{branches,
>> tags}/*". =A0The second effect is that "git svn fetch" will run but =
exit
>> quietly without actually pulling anything from the repository. =A0I
>> tracked down an existing thread on the mailing list from a while ago
>> (Feb 4th, title of "git-svn doesn't fetch anything"), but there was =
no
>> resolution.
>
> I've just run into this exact same issue.
>
>> There is a quick workaround, which was to make this change to match_=
paths:
>> < =A0 =A0 $self->{path_regex} ||=3D qr/^\/\Q$self->{path}\E\//;
>> ---
>> > =A0 =A0 $self->{path_regex} ||=3D qr/\/\Q$self->{path}\E\//;
>>
>> The additional "bar" directory gets pulled in when git-svn tries to
>> determine what paths to pull down, and tries to match
>> "/myproject/trunk" to "/bar/myproject/trunk". =A0I've merely put a
>> band-aid on the situation. =A0My perl is rudimentary at best, or I'd
>> have spent additional time to try to put in a "proper" patch, but wa=
s
>> wondering if anyone else had run into this problem and would be
>> willing to put in a fix (or point me in the right direction, that
>> works too).
>
> I messed about with disabling $Git::SVN::_minimize_url, but that seem=
ed
> to break other things.
>
> Made worse for me was the fact that my 'bar' in the present was renam=
ed
> from 'baz' in the past, so git-svn couldn't find it at r1. Very
> confusing!
>
> I'd like a nicer solution too.
>
> Tim
>
> --
> Tim Stoakes
>
