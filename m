From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] instaweb: make it compatible with Mac OS X 10.5's apache installation.
Date: Mon, 12 May 2008 19:52:55 +0200
Message-ID: <200805121952.55492.chriscool@tuxfamily.org>
References: <1210534569-48466-1-git-send-email-nathans@gmail.com> <B3990C52-0AF9-490C-86E1-B311144C6661@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: nathan spindel <nathans@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 19:49:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvc96-0003MT-7F
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 19:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756520AbYELRsQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 May 2008 13:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755886AbYELRsQ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 13:48:16 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:39133 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755824AbYELRsP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2008 13:48:15 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 77D5C1AB2DE;
	Mon, 12 May 2008 19:48:13 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5BC311AB2B0;
	Mon, 12 May 2008 19:48:13 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <B3990C52-0AF9-490C-86E1-B311144C6661@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81886>

Le dimanche 11 mai 2008, nathan spindel a =E9crit :
> On May 11, 2008, at 12:36 PM, nathan spindel wrote:
> > apache2_conf () {
> > -	test -z "$module_path" && module_path=3D/usr/lib/apache2/modules
> > +	# if there isn't an apache2 command on the system but there
> > +	# is a httpd command which looks like apache, use that instead
> > +	# for Mac OS X compatibility.
> > +	httpd_only=3D"`echo $httpd | cut -f1 -d' '`"
> > +	if ! type $httpd_only > /dev/null 2>&1
> > +	then
> > +		found_apache_command=3D1
> > +		httpd_parent_paths=3D"/usr/local/sbin /usr/sbin"
> > +		for i in $httpd_parent_paths; do
> > +			if test -x "$i/$httpd_only"
> > +			then
> > +				found_apache_command=3D0
> > +				break
> > +			fi
> > +		done
> > +
> > +		if test $found_apache_command !=3D 0
> > +		then
> > +			alt_apache=3D"httpd"
> > +			if type $alt_apache > /dev/null 2>&1
> > +			then
> > +				$alt_apache -v | grep Apache > /dev/null 2>&1
> > +				if test $? =3D=3D 0
> > +				then
> > +					httpd=3D`echo "$httpd" | sed "s/apache2/httpd/"`
> > +				else
> > +					for i in $httpd_parent_paths; do
> > +						if test -x "$i/$alt_apache"
> > +						then
> > +							$i/$alt_apache -v | grep Apache > /dev/null 2>&1
> > +							if test $? =3D=3D 0
> > +							then
> > +								httpd=3D`echo "$httpd" | sed "s/apache2/httpd/"`
> > +								break
> > +							fi
> > +						fi
> > +					done
> > +				fi
> > +			fi
> > +		fi
> > +	fi
>
> I'd like to see a cleaner implementation of this logic,=20

Maybe you can use a function like this not tested one:

check_cmd() {
	cmd=3D"$1"

	if type "$cmd" > /dev/null 2>&1; then
		if "$cmd" -v | grep Apache > /dev/null 2>&1; then
			httpd=3D$(echo "$cmd" | sed "s/apache2/httpd/")
		fi
	fi
}

Regards,
Christian.
