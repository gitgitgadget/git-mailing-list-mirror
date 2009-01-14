From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH next] git-notes: add test case for multi-line notes
Date: Wed, 14 Jan 2009 16:34:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901141627440.3586@pacific.mpi-cbg.de>
References: <496CF21C.2050500@trolltech.com> <496DF936.3060308@trolltech.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-184646799-1231947277=:3586"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Tor_Arne_Vestb=F8?= <tavestbo@trolltech.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 16:36:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN7ly-0004mf-Pt
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 16:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760372AbZANPds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 10:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758145AbZANPds
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 10:33:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:55020 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758483AbZANPdr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 10:33:47 -0500
Received: (qmail invoked by alias); 14 Jan 2009 15:33:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 14 Jan 2009 16:33:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18OTWsHTKYOuUVWN+dU8gytNrsVTnfN6okZLBuC+v
	CHTBmmh5Co/jeG
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <496DF936.3060308@trolltech.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105641>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-184646799-1231947277=:3586
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 14 Jan 2009, Tor Arne Vestbø wrote:

> The tests adds a third commit with a multi-line note. The output of
> git log -2 is then checked to see if the note lines are wrapped
> correctly, and that there's a line separator between the two commits.
> 
> Also, changed from using 'git diff' to test expect vs. output to use
> 'test_cmp', as I had problems getting correct results using the former.

You could skip the part that you had problems, as the test_cmp is 
obviously the correct thing to do.

> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index ba42c45..76bb6dd 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -8,8 +8,8 @@ test_description='Test commit notes'
> . ./test-lib.sh
> 
> cat > fake_editor.sh << \EOF
> -echo "$MSG" > "$1"
> -echo "$MSG" >& 2
> +echo -e "$MSG" > "$1"
> +echo -e "$MSG" >& 2

I seem to recall that we had plenty of fun substituting "echo -e" with 
"printf" whenever it entered the repository (... again...), as some 
platforms -- ahem, macosx, ahem -- are a bit peculiar with such options.

So you might want to make sure no % is passed as "$MSG", and use printf 
instead.

> +test_expect_success 'create multi-line notes (setup)' '
> +	: > a3 &&
> +	git add a3 &&
> +	test_tick &&
> +	git commit -m 3rd &&
> +	MSG="b3\nc3c3c3c3\nd3d3d3" git notes edit
> +
> +'

Minor style nit: maybe you want to have an empty line at the beginning, 
too...

> +cat > expect-multiline << EOF
> +commit 1584215f1d29c65e99c6c6848626553fdd07fd75
> +Author: A U Thor <author@example.com>
> +Date:   Thu Apr 7 15:15:13 2005 -0700
> +
> +    3rd
> +
> +Notes:
> +    b3
> +    c3c3c3c3
> +    d3d3d3
> +EOF
> +
> +echo >> expect-multiline
> +cat expect >> expect-multiline

Yeah.  My initial reaction was: "you could have that echo inside the cat 
<<EOF", but this is clearer.  Except that you should make sure that 
nothing is printed (M$' echo outputs something if you pass no parameters); 
printf "\n" would be my choice.

Other than that, very good: ACK.

Ciao,
Dscho

--8323328-184646799-1231947277=:3586--
