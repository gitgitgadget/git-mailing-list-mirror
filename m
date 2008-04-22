From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 2/7] git-submodule: Extract absolute_url & move absolute url logic to module_clone
Date: Tue, 22 Apr 2008 14:50:22 +0800
Message-ID: <46dff0320804212350t647492b2o649ddc40cfe43d6@mail.gmail.com>
References: <1208355577-8734-1-git-send-email-pkufranky@gmail.com>
	 <1208355577-8734-2-git-send-email-pkufranky@gmail.com>
	 <1208355577-8734-3-git-send-email-pkufranky@gmail.com>
	 <7v3ape5sip.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 08:51:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoCLO-0007KT-Sp
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 08:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755061AbYDVGuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 02:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755155AbYDVGuZ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 02:50:25 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:33535 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017AbYDVGuY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 02:50:24 -0400
Received: by an-out-0708.google.com with SMTP id d31so569420and.103
        for <git@vger.kernel.org>; Mon, 21 Apr 2008 23:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GOVIG+YlMg7J8SnUL/E7NPUIhvJ9qVCKLBZD+Tl4Yvg=;
        b=IfnA13RS1LaUdtCZH9rCrsYHOi3G/4rPk3PRtKWf4wgNC6vXn6fq9cYWAAThxwXr1KmvmS5psG03d6rLH84SoLZ1lUZ4xYgnr/gt2QTXZmuERu/ir8HTyeJLVnYfGAocn6YG4EG4hkNr6Z7A8Voz8UwqCOC4Li/gBnfo3VFh/Hg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hsNP+y9aspZUf1UTBy6rsS7CHSeIA3kO+jbPI3SjAOtfSjR/T3UfJew42U1dZlF33sNzAP690ZlaNapQp9E3lSHJm52XUPPUb58XJvFyV3L76SwPxZbn3E5KHFLpuKNkhqn3/5XrccF8pKVXIORA/WG0dCEAKoEqQekk5CC+Pf0=
Received: by 10.100.12.1 with SMTP id 1mr14082165anl.22.1208847022346;
        Mon, 21 Apr 2008 23:50:22 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Mon, 21 Apr 2008 23:50:22 -0700 (PDT)
In-Reply-To: <7v3ape5sip.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80070>

On Tue, Apr 22, 2008 at 2:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>  > This behaviour change breaks t7400 which uses relative url './.subrepo'.
>  > However, this test originally doesn't mean to test relative url with './',
>  > so fix the url as '.subrepo'.
>
>  Isn't ".subrepo" a relative URL that says "subdirectory of the current
>  one, whose name is .subrepo", exactly the same way as "./.subrepo" is?
>  Shouldn't they behave the same?
>
>  If the test found they do not behave the same, perhaps the new code is
>  broken in some way and isn't "fixing" the test simply hiding a bug?
>

I just want to unify the behaviour of handling relative url.

'git submodule add'  treats './foo' and 'foo' as different urls. The
1st one is relative to remote.origin.url, while the 2nd one is
relative the current directory. I think this kind of behaviour is
better for submodules, so i unify the handling of relative urls as
this.

With this kind of behaviour, i can set 'submodule.foo.url=./foo' in
.gitmodules or $GIT_DIR/config. And when remote.origin.url changes, i
have not to change submodule.foo.url if the super project and
submodule foo are always located on the same central host.

>
>  > +# Resolve relative url/path to absolute one
>  > +absolute_url () {
>  > +     case "$1" in
>  > +     ./*|../*)
>  > +             # dereference source url relative to parent's url
>  > +             url="$(resolve_relative_url $1)" ;;
>  > +     *)
>  > +             # Turn the source into an absolute path if it is local
>  > +             url=$(get_repo_base "$1") ||
>  > +             url=$1
>  > +             ;;
>  > +     esac
>  > +     echo "$url"
>  > +}
>  > +
>  >  #
>  >  # Map submodule path to submodule name
>  >  #
>  > @@ -112,7 +127,7 @@ module_info() {
>  >  module_clone()
>  >  {
>  >       path=$1
>  > -     url=$2
>  > +     url=$(absolute_url "$2")
>  >
>  >       # If there already is a directory at the submodule path,
>  >       # expect it to be empty (since that is the default checkout
>
>  Why does this call-site matter?  The URL is given to "git-clone" which I
>  think does handle the relative URL just fine???
>

As said above.



-- 
Ping Yin
