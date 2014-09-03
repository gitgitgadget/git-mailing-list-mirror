From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] parse-options: detect attempt to add a duplicate short
 option name
Date: Wed, 3 Sep 2014 14:58:34 -0700
Message-ID: <20140903215834.GZ18279@google.com>
References: <1409753034-9459-1-git-send-email-johan@herland.net>
 <1409753034-9459-3-git-send-email-johan@herland.net>
 <xmqq7g1kxzxi.fsf@gitster.dls.corp.google.com>
 <xmqq1trsxzgy.fsf_-_@gitster.dls.corp.google.com>
 <54077A3E.20703@web.de>
 <xmqqoauwwh2c.fsf@gitster.dls.corp.google.com>
 <20140903214624.GY18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 23:59:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPIZn-0001mI-CD
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 23:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbaICV6k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2014 17:58:40 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:48463 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162AbaICV6i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 17:58:38 -0400
Received: by mail-pa0-f44.google.com with SMTP id rd3so18592265pab.31
        for <git@vger.kernel.org>; Wed, 03 Sep 2014 14:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9D7zr2XuAvmVUSTmt5Ji2ksYyDK7U7pIA2fk0giUW4Y=;
        b=RbrFKEzPuhPJhi0PBOizNY9V/7rae00iWG5TlFwPe9yv9Qo3oqP5QYU6ojNYoB9OSk
         v5Aq/5yFoPtjXHnaX2WWCSzJAdzjpJHYLGcL4jdcFwod/eu6KB9KHyormsMswl5D/kdO
         rZKEs4lr8o9mTpPoWS1DdOfcfkIQIY8oGOTCrhKqJgkfJwvieMjf4CHn8DA7DhYZN2hB
         aXoknvf+Bmra8Mp0WaqgY9DQiYjQXdJR9IniCMnMcpaG9sCmobmlSEgDVuIXCeaORUz/
         4vU82INkC/3ydX7Z8okqwF7l9t2qrmLf3uQXzj6NoExVDs2TRe4qMj8IPsRfUIXPfxYP
         C60w==
X-Received: by 10.66.139.106 with SMTP id qx10mr464629pab.126.1409781517632;
        Wed, 03 Sep 2014 14:58:37 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id dn5sm7794236pbb.2.2014.09.03.14.58.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Sep 2014 14:58:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140903214624.GY18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256422>

On Wed, Sep 03, 2014 at 02:46:25PM -0700, Jonathan Nieder wrote:
> Junio C Hamano wrote:
>=20
> > --- a/parse-options.c
> > +++ b/parse-options.c
> > @@ -345,12 +345,27 @@ static void check_typos(const char *arg, cons=
t struct option *options)
> >  static void parse_options_check(const struct option *opts)
> >  {
> >  	int err =3D 0;
> > +	char short_opts[128];
> > +
> > +	memset(short_opts, '\0', sizeof(short_opts));
> > =20
> >  	for (; opts->type !=3D OPTION_END; opts++) {
> >  		if ((opts->flags & PARSE_OPT_LASTARG_DEFAULT) &&
> >  		    (opts->flags & PARSE_OPT_OPTARG))
> >  			err |=3D optbug(opts, "uses incompatible flags "
> >  					"LASTARG_DEFAULT and OPTARG");
> > +		if (opts->short_name) {
> > +			struct strbuf errmsg =3D STRBUF_INIT;
> > +			if (opts->short_name < ' ' || 0x7F <=3D opts->short_name)
> > +				strbuf_addf(&errmsg, "invalid short name (0x%02x)",
> > +					    opts->short_name);
> > +			else if (short_opts[opts->short_name]++)
>=20
> What happens on platforms with a signed char?

Ah, I see now that the "< ' '" check would catch that.

With Ren=E9's suggestions squashed in, that becomes

 parse-options.c               | 9 +++++++++
 t/t1502-rev-parse-parseopt.sh | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index e7dafa8..6ad7d90 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -347,12 +347,21 @@ static void check_typos(const char *arg, const st=
ruct option *options)
 static void parse_options_check(const struct option *opts)
 {
 	int err =3D 0;
+	char short_opts[128];
+
+	memset(short_opts, '\0', sizeof(short_opts));
=20
 	for (; opts->type !=3D OPTION_END; opts++) {
 		if ((opts->flags & PARSE_OPT_LASTARG_DEFAULT) &&
 		    (opts->flags & PARSE_OPT_OPTARG))
 			err |=3D optbug(opts, "uses incompatible flags "
 					"LASTARG_DEFAULT and OPTARG");
+		if (opts->short_name) {
+			if (opts->short_name <=3D ' ' || 0x7F <=3D opts->short_name)
+				err |=3D optbug(opts, "invalid short name");
+			else if (short_opts[opts->short_name]++)
+				err |=3D optbug(opts, "short name already used");
+		}
 		if (opts->flags & PARSE_OPT_NODASH &&
 		    ((opts->flags & PARSE_OPT_OPTARG) ||
 		     !(opts->flags & PARSE_OPT_NOARG) ||
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt=
=2Esh
index 922423e..ebe7c3b 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -19,7 +19,7 @@ sed -e 's/^|//' >expect <<\END_EXPECT
 |    -d, --data[=3D...]      short and long option with an optional ar=
gument
 |
 |Argument hints
-|    -b <arg>              short option required argument
+|    -B <arg>              short option required argument
 |    --bar2 <arg>          long option required argument
 |    -e, --fuz <with-space>
 |                          short and long option required argument
@@ -51,7 +51,7 @@ sed -e 's/^|//' >optionspec <<\EOF
 |d,data?   short and long option with an optional argument
 |
 | Argument hints
-|b=3Darg     short option required argument
+|B=3Darg     short option required argument
 |bar2=3Darg  long option required argument
 |e,fuz=3Dwith-space  short and long option required argument
 |s?some    short option optional argument
--=20
2.1.0.rc2.206.gedb03e5
