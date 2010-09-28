From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH v3 1/3] tests: Prepare --textconv tests for correctly-failing conversion program
Date: Tue, 28 Sep 2010 16:20:31 +0400
Message-ID: <20100928122031.GC29525@landau.phys.spbu.ru>
References: <cover.1285351816.git.kirr@landau.phys.spbu.ru> <66d4603c7e21561557f612690d6196e7ae0b38f9.1285351816.git.kirr@landau.phys.spbu.ru> <7vsk0vyriw.fsf@alter.siamese.dyndns.org> <20100928120722.GA29525@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl??ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 14:20:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ZAm-000256-Mn
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 14:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab0I1MUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 08:20:33 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:52148 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab0I1MUc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 08:20:32 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 8EF8FFF72A; Tue, 28 Sep 2010 16:20:31 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <20100928120722.GA29525@landau.phys.spbu.ru>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157414>

On Tue, Sep 28, 2010 at 04:07:22PM +0400, Kirill Smelkov wrote:
> On Mon, Sep 27, 2010 at 11:23:35AM -0700, Junio C Hamano wrote:
> > Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:
> 
> 
> > > +sed 's/^bin:/converted:/' "$@" >helper.out
> > 
> > Minor nit: this is inconsistent with the check done with grep above that
> > insists that the colon is followed by a SP.
> 
> Yes, you are right. I'll amend it.
> 
> > > diff --git a/t/t4042-diff-textconv-caching.sh b/t/t4042-diff-textconv-caching.sh
> > > index 91f8198..7668099 100755
> > > --- a/t/t4042-diff-textconv-caching.sh
> > > +++ b/t/t4042-diff-textconv-caching.sh
> > > @@ -5,18 +5,19 @@ test_description='test textconv caching'
> > >  
> > >  cat >helper <<'EOF'
> > >  #!/bin/sh
> > > -sed 's/^/converted: /' "$@" >helper.out
> > > +grep -q '^bin: ' "$@" || { echo "E: $@ is not \"binary\" file" 1>&2; exit 1; }
> > 
> > You are not feeding arguments you think you are to the above "echo":
> > 
> >         $ cat >/var/tmp/j.sh <<\EOF
> >         #!/bin/sh
> >         e () {
> >                 i=0
> >                 for s
> >                 do
> >                         i=$(( $i + 1 ))
> >                         echo "$i: $s"
> >                 done
> >         }
> >         f () {
> >                 e "E: $@ is not binary"
> >         }
> >         f 1 "2 3" 4
> >         EOF
> >         $ sh /var/tmp/j.sh
> >         1: E: 1
> >         2: 2 3
> >         3: 4 is not binary
> > 
> > Granted, echo is forgiving and will concatenate the arguments it gets with
> > a space in between, but you would either want to either:
> > 
> >  (1) make it more explicit that helper gets only one argument, by saying
> >      "$1" instead of "$@", in all places in the helper script; or
> > 
> >  (2) if you are planning to make 'helper' capable of handling multiple
> >      input files, show the error message for the ones that are not binary
> >      (you would probably need a loop for that).
> > 
> > I think (1) would be sufficient in this case.
> 
> I too think (1) is right. It was just that originally there was $@
> (which I now understand was wrong). So ok to apply the following patch
> on top of this series? (I assume it's ok, and will repost the whole
> thing)
> 
> ---- 8< ----
> 
> From: Kirill Smelkov <kirr@mns.spb.ru>
> Date: Tue, 28 Sep 2010 15:34:48 +0400
> Subject: [PATCH 4/4] t4042,t8006,t8007: Textconv converter should take only one argument
> 
> Textconv helper in this tests was incorrectly referencing $@, which goes
> agains textconv "spec". I quote Documentation/gitattributes.txt
> 
> """ The `textconv` config option is used to define a program for
>     performing such a conversion. The program should take a single
>     argument, the name of a file to convert, and produce the
>     resulting text on stdout. """
> 
> So correct textconv helpers to use $1 instead.
> 
> Noticed-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
> ---
>  t/t4042-diff-textconv-caching.sh |    4 ++--
>  t/t8006-blame-textconv.sh        |    4 ++--
>  t/t8007-cat-file-textconv.sh     |    4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/t/t4042-diff-textconv-caching.sh b/t/t4042-diff-textconv-caching.sh
> index 68fee12..6aaa10b 100755
> --- a/t/t4042-diff-textconv-caching.sh
> +++ b/t/t4042-diff-textconv-caching.sh
> @@ -5,8 +5,8 @@ test_description='test textconv caching'
>  
>  cat >helper <<'EOF'
>  #!/bin/sh
> -grep -q '^bin: ' "$@" || { echo "E: $@ is not \"binary\" file" 1>&2; exit 1; }
> -sed 's/^bin: /converted: /' "$@" >helper.out
> +grep -q '^bin: ' "$1" || { echo "E: $1 is not \"binary\" file" 1>&2; exit 1; }
> +sed 's/^bin: /converted: /' "$1" >helper.out
>  cat helper.out
>  EOF
>  chmod +x helper

Please ignore this - changing so breaks textconv cache tests in this
file.

I'll come up with updated patch.

Sorry for the noise...
