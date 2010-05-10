From: Tatsuhiko Miyagawa <miyagawa@gmail.com>
Subject: Re: gitweb, FastCGI and PSGI/Plack
Date: Sun, 9 May 2010 17:59:11 -0700
Message-ID: <t2n693254b91005091759ye577992y32d2b6a41d7d8c45@mail.gmail.com>
References: <g2s693254b91005091428ib188cbd1le5ffa90eace741a8@mail.gmail.com>
	 <201005100105.49985.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Vereshagin <peter@vereshagin.org>,
	Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 02:59:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBHLc-0004zy-K9
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 02:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797Ab0EJA7N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 May 2010 20:59:13 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50095 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463Ab0EJA7M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 May 2010 20:59:12 -0400
Received: by gwj19 with SMTP id 19so1640108gwj.19
        for <git@vger.kernel.org>; Sun, 09 May 2010 17:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RixNM4Bjy/FjN+8z0aSn/6KEQ7anVKxS2Q88xE3/Lp8=;
        b=BuiLfCgj4vVIuQXtgzeGloQ/X1vaDvMyTiI1G7xGAhDar3AD/tZDHy8sjArMV6H6jt
         RoPFXuH5jXswQdefqeWQpbNRalzUGo1BqBTtFWWudv9H23fF0wyN9RqItAXBs+n9VMpZ
         qpW1U4jvqh1PrTQDkFpg6kgr/e1sb0yIt2s/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LUUj+xm17yt6tWMJ4+PuvsvYXeGlJx03CofF4/UzBtpjGKXYWAEIZ4casuXU1EyeOz
         I9CPybZQC4r4qpaeqiLywR86nG1Y6+vr/VFRm0FeNsJh/2NNKkKIR5eiRnOG3MS0O5vI
         899d7A8BRq9tSKmjHOBmXZmMg8V5P7/5eSGhs=
Received: by 10.231.170.84 with SMTP id c20mr1683098ibz.62.1273453151782; Sun, 
	09 May 2010 17:59:11 -0700 (PDT)
Received: by 10.231.154.79 with HTTP; Sun, 9 May 2010 17:59:11 -0700 (PDT)
In-Reply-To: <201005100105.49985.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146755>

On Sun, May 9, 2010 at 4:05 PM, Jakub Narebski <jnareb@gmail.com> wrote=
:

> Moving to PSGI, or adding possibility to run gitweb as PSGI script (l=
ike
> the series adds *ability* to run gitweb as FastCGI script) by modifyi=
ng
> gitweb would not be that easy, even with help of CGI::PSGI.

You don't need it - since you can just use Plack::App::WrapCGI.
>
> CGI::Compile was referring to an alternate approach, where instead of
> modifying gitweb to be able to run it as FastCGI script (you can run =
it
> as CGI script and as ModPerl::Registry script from mod_perl) there wa=
s
> added gitweb.fcgi wrapper:

and the .fcgi wrapper can just use Plack::Loader, or the plackup
executable with FCGI environment variable set, to DWIM.

> One can of course use this approach wrapping gitweb to be run on PSGI=
,
> using CGI::Emulate::PSGI (via Plack::App::WrapCGI), which in turn use=
s
> CGI::Compile. =A0The gitweb.fcgi wrapper could use CGI::Emulate::FCGI=
=2E..
> if it existed.

Again, you still don't understand - once your CGI script is turned
into PSGI, plackup can take over the web server interface, including
the FastCGI interface. If you need .fcgi wrapper to be spawned from
web servers, just put plackup command line call (or Plack::Runner or
::Loader) in the .fcgi script.

> NB I use the following gitweb.psgi wrapper to run gitweb from "placku=
p"
> for tests (after running "make gitweb", of course, and with appropria=
te
> gitweb_config.perl, unversioned, in gitweb/ alongside gitweb.perl, th=
e
> gitweb.psgi wrapper, and generated gitweb.cgi):

>> `plackup -s FCGI` makes your PSGI app a fastcgi handler using FCGI.p=
m,
>> or `plackup -s Net::FastCGI` does the same but using Net::FastCGI,
>> pure perl alternative.
>
> It is a pity that Plack::App::WrapFCGI / FCGI::Emulate::PSGI does not
> exist, so that gitweb.psgi wrapper would not require indirectly
> CGI::Compile.

it's not a pity - it's the simplification by wrapping CGI environment
into PSGI, which is a pure perl web server interface that then can be
turned into ANY web server handlers including standalone, CGI,
=46astCGI, mod_perl and SCGI.




--=20
Tatsuhiko Miyagawa
