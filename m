From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v3] config: add support for http.<url>.* settings
Date: Fri, 12 Jul 2013 06:07:35 -0700
Message-ID: <F5272E14-188E-4199-9523-D2ED66574D91@gmail.com>
References: <9e7edfbc83a7284615af4ca0de39c1b@f74d39fa044aa309eaea14b9f57fe79> <20130712095923.GA4695@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 12 15:07:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxd4a-0001KC-LT
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 15:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855Ab3GLNHk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jul 2013 09:07:40 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:33618 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964819Ab3GLNHj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jul 2013 09:07:39 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so9054705pbb.0
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 06:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=3fkr+bxtiOeFEWcxqB+ESjXonH3g06iV80YvH2Ll8bg=;
        b=jj5jMl8nd5jLShVUr3aQa+XxeJbrOhx9ITmyIYv0HAqfIzGMUi0JSH65pv1nhbr7/9
         9+W+TuzGaWAsVXl2QWJkIjpMCcJJyMrtk1rWBlm4lPaNdV5Z3qbJbtuxRo1BTMaixgyg
         aGxlZilAr/9zxBQ8UX6+cnYbvtY6v2gV5l4LpQAB3S+xlD+hQIjZT8QR+sSZLyn/fK8R
         dh1HvmYsGPXEQjnXs/xf6eRQKpJwq5PQkv8huzZjAdhWeEoYjcKA0A3tuBrmW76FRHky
         3GSutilXgikI9qVm9QcsE/yISM3DMQbtu6nz+tObGaYHhxNEQacKKxJWFS/zVyCxxn6C
         VY8A==
X-Received: by 10.68.43.8 with SMTP id s8mr41919514pbl.139.1373634459215;
        Fri, 12 Jul 2013 06:07:39 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id x8sm45319632pbb.39.2013.07.12.06.07.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 06:07:38 -0700 (PDT)
In-Reply-To: <20130712095923.GA4695@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230198>

On Jul 12, 2013, at 02:59, Jeff King wrote:
> On Thu, Jul 11, 2013 at 02:50:03PM -0700, Kyle J. McKay wrote:
>
> A few comments on the implementation:
>
>> +enum http_option_type {
>> +	opt_post_buffer =3D 0,
>> +	opt_min_sessions,
>
> We usually put enum fields in ALL_CAPS to mark them as constants =20
> (though
> you can find few exceptions in the code).

OK.

>> +static size_t http_options_url_match_prefix(const char *url,
>> +					    const char *url_prefix,
>> +					    size_t url_prefix_len)
>> +{
>
> It looks like you're matching the URLs as raw strings, and I don't se=
e
> any canonicalization going on. What happens if I have
> "https://example.com/foo+bar" in my config, but then I visit
> "https://example.comfoo%20bar"?

The documentation for http.<url>.* says:

>> +http.<url>.*::
> [snip]
>> +       Note that <url> must match the url exactly (other than =20
>> possibly being a
>> +       prefix).  This means any user, password and/or port setting =
=20
>> that appears
>> +       in a url must also appear in <url> to have a successful =20
>> match.
>> +

> Or what about optional components? If I have "https://example.com" =20
> in my
> config, but I am visiting "https://peff@example.com/", shouldn't it
> match? The config spec is more general than my specific URL; you woul=
d
> not want it to match in the opposite direction, though.

They have to be included to match.  Any URL-encoding present in the =20
URL given to git needs to be duplicated in the URL in the config file =20
exactly or there will not be a match.

> That does make your by-length ordering impossible, but I don't think =
=20
> you
> can do it in the general case. If I have:
>
>  [http "http://peff@example.com"] foo =3D 1
>  [http "http://example.com:8080"] foo =3D 2
>
> and I visit "http://peff@example.com:8080", which one is the winner?

If I were to spilt everything out, then I would only have the second =20
one match.  The first config is on a different port, quite possibly an =
=20
entirely different service.  It shouldn't match.  Consider if you were =
=20
port forwarding with ssh, services from many different machines would =20
all be on localhost on different ports.  The second one is on the same =
=20
port and matches because it's slightly more general (missing the user =20
name), but it's clearly talking to the same service.

As the patch stands now, neither of them would match since the =20
documentation requires an exact match (except for possibly being a =20
prefix).

I don't think it's necessary to split the URL apart though.  Whatever =20
URL the user gave to git on the command line (at some point even if =20
it's now stored as a remote setting in config) complete with URL-=20
encoding, user names, port names, etc. is the same url, possibly =20
shortened, that needs to be used for the http.<url>.option setting.

I think that's simple and very easy to explain and avoids user =20
confusion and surprise while still allowing a default to be set for a =20
site but easily overridden for a portion of that site without needing =20
to worry about the order config files are processed or the order of =20
the [http "<url>"] sections within them.

> I don't think there is an unambiguous definition. I'd suggest =20
> instead just
> using the usual "last one wins" strategy that our config uses. It has
> the unfortunate case that:
>
>  [http "http://example.com"]
>     foo =3D 1
>  [http]
>     foo =3D 2
>
> will always choose http.foo=3D2, but I don't think that is a big prob=
lem
> in practice.

I think that violates the principle of least surprise.  In this case:

[http "https://cacert.org"]
   sslVerify =3D false
[http]
   sslVerify =3D true

the intention here is very clear -- for cacert.org only, sslVerify =20
should be false.  To have the [http] setting step on the [http "https:/=
/cacert.org=20
"] setting seems completely surprising and unexpected.

The "last one wins" is still in effect though for the same paths.  If =20
you have:

# System config
[http "https://cacert.org"]
   sslVerify =3D false

# Global config
[http "https://cacert.org"]
   sslVerify =3D true

The setting from the Global config still wins.

> You often only set one or the other, and in the cases where
> you want to have a non-standard default and then override it with
> another host-specific case, the "last one wins" rule makes it simple =
=20
> to
> explain that you need to specify keys in most-general to most-specifi=
c
> order.

Unless, of course, different config files are involved and that's not =20
possible without duplicating entries into the later-processed config =20
file.

>> static int http_options(const char *var, const char *value, void *cb=
)
>> {
>> -	if (!strcmp("http.sslverify", var)) {
>> +	const char *url =3D (const char *)cb;
>
> No need to cast from void, this isn't C++. :)

Indeed.

> The rest of the http_options() changes look like what I'd expect.
>
>> @@ -344,7 +479,7 @@ void http_init(struct remote *remote, const =20
>> char *url, int proactive_auth)
>>
>> 	http_is_verbose =3D 0;
>>
>> -	git_config(http_options, NULL);
>> +	git_config(http_options, (void *)url);
>
> No need to cast again. :)

Ah, but there is in order to avoid a warning:

http.c: In function =91http_init=92:
http.c:481: warning: passing argument 2 of =91git_config=92 discards =20
qualifiers from pointer target type

url is a const char * and git_config takes a void *.

> However, it may be worth mentioning in the documentation that the =20
> config
> options operate on the URL you give git, _not_ necessarily on the =20
> actual
> URL you are hitting at any given moment (the gitcredentials(7) page
> should probably make the same distinction).

Can do that.  Will have to think about the wording for a while and =20
mention the %XX escapes as well.