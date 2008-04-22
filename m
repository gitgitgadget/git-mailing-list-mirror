From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 2/7] git-submodule: Extract absolute_url & move absolute url logic to module_clone
Date: Tue, 22 Apr 2008 15:00:21 +0800
Message-ID: <46dff0320804220000l1872ebf1vde269953d89c755f@mail.gmail.com>
References: <1208355577-8734-1-git-send-email-pkufranky@gmail.com>
	 <1208355577-8734-2-git-send-email-pkufranky@gmail.com>
	 <1208355577-8734-3-git-send-email-pkufranky@gmail.com>
	 <7v3ape5sip.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 09:01:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoCV4-0001XZ-1G
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 09:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929AbYDVHAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 03:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754935AbYDVHAX
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 03:00:23 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:50122 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896AbYDVHAW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 03:00:22 -0400
Received: by an-out-0708.google.com with SMTP id d31so570088and.103
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 00:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zthEr1oAjUEeduXso594+DpY/yRZZFx17JDfM/9odvw=;
        b=sru84DKdQA4Qco5lniOzVZhuL7ARu0tbGmxRfz/nJo+KpKF/i7tv/ptP1yyxyhWdFDic4BBdFiUR9mcW7UqQO5lNV8ymw6QHyfwjUE9viEkG+dMapuf5bWwg4Vni+twzGDXPKC6yZCJnmLhGbOzCY/tckUCAOtZcdBqpqTXEAWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q3Er6rj380tfacQhn4HwBPxt+m5dIUaPfwfZj7SUeIOAeCHNvbOvo+NZeaJ4cSEuaFNdwFgDBPjWI0EKVfMMpRreBmvQHYwpFLvnfp58O2QeHFO4pAZIlpE1puFqbBQgInWZ/NUUjTq0pZwdqwYU8Voo7rlZ9zP7FFOrCjdQnUA=
Received: by 10.100.140.12 with SMTP id n12mr14022013and.147.1208847621620;
        Tue, 22 Apr 2008 00:00:21 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Tue, 22 Apr 2008 00:00:21 -0700 (PDT)
In-Reply-To: <7v3ape5sip.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80071>

On Tue, Apr 22, 2008 at 2:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>
>  > Extract function absolute_url to remove code redundance and inconsistence in
>  > cmd_init and cmd_add when resolving relative url/path to absolute one.
>  >
>  > Also move resolving absolute url logic from cmd_add to module_clone which
>  > results in a litte behaviour change: cmd_update originally doesn't
>  > resolve absolute url but now it will.
>
>  Hmmm.  Somehow I find this unreadable and hard to parse.
>
>
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
>  I dunno...
>
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

>  Hmmm.  Doesn't "foo" generally mean the same thing as "./foo" in the sense
>  both are relative to the current directory?

Following was my answer days ago

There is a little inconsistence in current logic

1. git submodule add ./foo will expand foo with remote.origin.url and
    init an entry in .gitmodules as "submodule.foo.url=$remoteoriginurl/foo"
2. git submodule update will not expand ./foo if  there is an entry
    "submodule.foo.url=./foo"  in $GIT_DIR/config

I tend to add the url as is when "git submodule add", and then expand
the url when running "git submodule update". So this will result that
the second case expands './foo' as "$remoteoriginurl/foo" instead of
"foo".

And this is the reason i expand './foo' in module_clone.

-- 
Ping Yin
