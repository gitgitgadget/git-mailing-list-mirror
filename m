From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 4/5] Simplify editor selection logic
Date: Wed, 30 Jan 2008 08:28:28 +0100
Message-ID: <20080130072828.GA24648@diana.vm.bytemark.co.uk>
References: <20080129030059.926.29897.stgit@yoghurt> <20080129030349.926.45486.stgit@yoghurt> <200801292109.37785.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Wed Jan 30 08:29:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK7OJ-0006u5-ON
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 08:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112AbYA3H3L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jan 2008 02:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754372AbYA3H3K
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 02:29:10 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3524 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbYA3H3J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 02:29:09 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JK7My-0006UI-00; Wed, 30 Jan 2008 07:28:28 +0000
Content-Disposition: inline
In-Reply-To: <200801292109.37785.kumbayo84@arcor.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72044>

On 2008-01-29 21:09:37 +0100, Peter Oberndorfer wrote:

> Since i personally dislike having a separate config for the editor
> in git/stgit i locally use this patch. unfortunately it makes the
> whole editor searching thing more complex :-( But i am sure it is
> possible to rewrite the code to something easier with some more
> python knowledge :-/ So it is not meant for direct applying, just
> for discussion...

I like the intention. What I'd like to do is to let the code _use_ the
stgit.editor variable, but not advertise it in the docs except for
noting that "this is deprecated and will go away in the future, but
for now it's still effective".

> +. the 'GIT_EDITOR' environment variable
>  . the 'stgit.editor' GIT configuration variable
> +. the 'core.editor' GIT configuration variable
> +. the 'VISUAL' environment variable
>  . the 'EDITOR' environment variable

That's a very nice order. (For completeness, the list should end with
"vi", though. And I'd like that deprecation note for stgit.editor,
unless someone has strong objections.)

>      # the editor
> -    editor =3D config.get('stgit.editor')
> +    editor =3D None
> +    if 'GIT_EDITOR' in os.environ:
> +        editor =3D os.environ['GIT_EDITOR']
> +    if not editor:
> +        editor =3D config.get('stgit.editor')
> +    if not editor:
> +        editor =3D config.get('core.editor')
>      if editor:
>          pass
> +    elif 'VISUAL' in os.environ:
> +        editor =3D os.environ['VISUAL']
>      elif 'EDITOR' in os.environ:
>          editor =3D os.environ['EDITOR']
>      else:

You could write it kind of like this:

  def e(key): return os.environ.get(key, None)
  def c(key): return config.get(key)
  editor =3D filter(None, [e('GIT_EDITOR'), c('stgit.editor'), c('core.=
editor'),
                         e('VISUAL'), e('EDITOR'), 'vi'])[0]

Of course, if we're going to have code like this in several places
(you already mentioned the pager), we could build a function like
this:

  editor =3D get_config(['GIT_EDITOR', 'stgit.editor', 'core.editor',
                       'VISUAL', 'EDITOR'], default =3D 'vi')

that would differentiate between env variables and conf keys by
looking for dots in the name or something.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
