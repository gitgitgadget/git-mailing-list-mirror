From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/5] gitweb: Option for filling only specified info in fill_project_list_info
Date: Fri, 10 Feb 2012 00:52:26 +0100
Message-ID: <201202100052.26399.jnareb@gmail.com>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com> <201202092336.48772.jnareb@gmail.com> <7v4nuzvbnr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 00:52:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvdmt-00058i-Cj
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 00:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758473Ab2BIXwX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 18:52:23 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60779 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757894Ab2BIXwW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 18:52:22 -0500
Received: by eaah12 with SMTP id h12so743503eaa.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 15:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=iBEhWlGLhCzW+P0QpTmKJfJ0u+oMnBZzOEFE9vNupdA=;
        b=dFQLGp/6ouCXOZQwFCgMVr1S98ArUy6ZXGZDIOXU11mo+X7WDOWqhviaPAUqtXeyen
         Hr94Dmtdtc0WbpV9uiQq39TldlNJt4JtvI48iEDWvjEo7RNFd5ECiDgnAkuE2VTTlvw7
         hajobU2ZsJtFc+wdrGLT5RCar8/8+pDWp0sOU=
Received: by 10.14.33.212 with SMTP id q60mr988345eea.114.1328831540729;
        Thu, 09 Feb 2012 15:52:20 -0800 (PST)
Received: from [192.168.1.13] (abvq91.neoplus.adsl.tpnet.pl. [83.8.214.91])
        by mx.google.com with ESMTPS id y12sm15211957eeb.11.2012.02.09.15.52.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 15:52:20 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v4nuzvbnr.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190344>

On Fri, 10 Feb 2012, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>>> The lack of any real use of @fill_only in this patch also makes it =
hard to
>>> judge if the new API gives a useful semantics.  I would, without lo=
oking
>>> at the real usage in 2/5 patch, na=C3=AFvely expect that such a laz=
y filling
>>> scheme would say "I am going to use A, B and C; I want to know if a=
ny of
>>> them is missing, because I need values for all of them and I am goi=
ng to
>>> call a helper function to fill them if any of them is missing. Havi=
ng A
>>> and B is not enough for the purpose of this query, because I still =
need to
>>> know C and I would call the helper function that computes all of th=
em in
>>> such a case. Even though it might be wasteful to recompute A and B,
>>> computing all three at once is the only helper function available t=
o me".
>>>=20
>>> So for a person who does not have access to the real usage of the n=
ew API,
>>> being able to give only a single $key *appears* make no sense at al=
l, and
>>> also the meaning of the @fill_only parameter is unclear, especially=
 the
>>> part that checks if that single $key appears in @fill_only.
>>
>> ...
>> information that is not already present.  If @fill_only is nonempty,=
 it
>> fills only selected information, again only if it is not already pre=
sent.
>> @fill_only empty means no restrictions... which probably is not very=
 obvious,
>> but is documented.
>>
>> project_info_needs_filling() returns true if $key is not filled and =
is
>> interesting.
>=20
> That still does not answer the fundamental issues I had with the pres=
ented
> API: why does it take only a single $key (please re-read my "A, B and=
 C"
> example), and what does that single $key intersecting with @fill_only=
 have
> anything to do with "needs-filling"?

project_info_needs_filling() in absence of @fill_only is just a thin
wrapper around "!defined $pr->{$key}", it checks for each key if it nee=
ds
to be filled.

It is used like this

  if (project_info_needs_filled("A", "A, B, C")) {
     fill A
  }
  if (project_info_needs_filled("B", "A, B, C")) {
     fill B
  }
  ...
=20
> After all, that 'age' check actually wants to fill 'age' and 'age_str=
ing'
> in the project. Even if some other codepath starts filling 'age' in t=
he
> project with a later change, the current callers of fill_project_list=
_info
> expects _both_ to be filled. So "I know the current implementation fi=
lls
> both at the same time, so checking 'age' alone is sufficient" is not =
an
> answer that shows good taste in the API design.

It is not as much matter of API, as the use of checks in loop in=20
fill_project_list_info().

What is now

  my (@activity) =3D git_get_last_activity($pr->{'path'});
  unless (@activity) {
  	next PROJECT;
  }
  ($pr->{'age'}, $pr->{'age_string'}) =3D @activity;

should be

  if (!defined $pr->{'age'} ||
      !defined $pr->{'age_string'}) {
  	my (@activity) =3D git_get_last_activity($pr->{'path'});
  	unless (@activity) {
  		next PROJECT;
  	}
  	($pr->{'age'}, $pr->{'age_string'}) =3D @activity;
  }

which would translate to

  if (project_info_needs_filled($pr, 'age') ||
      project_info_needs_filled($pr, 'age_string') {
  	my (@activity) =3D git_get_last_activity($pr->{'path'});
  	unless (@activity) {
  		next PROJECT;
  	}
  	($pr->{'age'}, $pr->{'age_string'}) =3D @activity;
  }

and then with @fill_only

  if (project_info_needs_filled($pr, 'age', @fill_only) ||
      project_info_needs_filled($pr, 'age_string', @fill_only) {
  	my (@activity) =3D git_get_last_activity($pr->{'path'});
  	unless (@activity) {
  		next PROJECT;
  	}
  	($pr->{'age'}, $pr->{'age_string'}) =3D @activity;
  }

The same should be done for 'descr_long' and 'descr' which are also
always filled together.

--=20
Jakub Narebski
Poland
