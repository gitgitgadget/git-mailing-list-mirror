From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: [PATCH] Be nice with compilers that do not support runtime paths at all.
Date: Sun, 21 Oct 2007 23:56:22 +0200
Message-ID: <09169ECD-19E1-44D1-8539-71EBBA3826A8@lrde.epita.fr>
References: <7vsl4rdgf4.fsf@gitster.siamese.dyndns.org> <1191450052-23619-1-git-send-email-tsuna@lrde.epita.fr> <7vejgbdbyn.fsf@gitster.siamese.dyndns.org> <34DAC3CA-E226-4488-8B03-FC45A6A95F78@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-3--51782542"
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 23:56:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijimp-0001X4-28
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 23:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbXJUV4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 17:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbXJUV4a
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 17:56:30 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:50809 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbXJUV43 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 17:56:29 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IjimZ-0004M2-Bx
	for git@vger.kernel.org; Sun, 21 Oct 2007 23:56:27 +0200
In-Reply-To: <34DAC3CA-E226-4488-8B03-FC45A6A95F78@lrde.epita.fr>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61912>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-3--51782542
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Oct 4, 2007, at 5:59 PM, Benoit SIGOURE wrote:

> On Oct 4, 2007, at 1:18 AM, Junio C Hamano wrote:
>
>> Benoit Sigoure <tsuna@lrde.epita.fr> writes:
>>
>>> diff --git a/Makefile b/Makefile
>>> index a1fe443..7c6c453 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -100,6 +100,9 @@ all::
>>>  # that tells runtime paths to dynamic libraries;
>>>  # "-Wl,-rpath=/path/lib" is used instead.
>>>  #
>>> +# Define NO_RPATH if your dynamic loader doesn't support runtime  
>>> paths at
>>> +# all.
>>> +#
>>>  # Define USE_NSEC below if you want git to care about sub-second  
>>> file mtimes
>>>  # and ctimes. Note that you need recent glibc (at least 2.2.4)  
>>> for this, and
>>>  # it will BREAK YOUR LOCAL DIFFS! show-diff and anything using  
>>> it will likely
>>
>> Thanks for this part;
>>
>>> @@ -507,6 +510,7 @@ ifeq ($(uname_S),Darwin)
>>>  			BASIC_LDFLAGS += -L/opt/local/lib
>>>  		endif
>>>  	endif
>>> +        NO_RPATH = YesPlease
>>>  endif
>>
>> I'll let Darwin users to fight the defaults for this part out.
>
> No more replies on this thread, and the Apple documentation  
> confirms that there is no rpath support in the dynamic loader of  
> OSX 10.4 and before.  I don't know about the soon-to-be-released  
> 10.5 aka Leopard.
>
>>> @@ -521,7 +525,10 @@ ifndef NO_CURL
>>>  	ifdef CURLDIR
>>>  		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
>>>  		BASIC_CFLAGS += -I$(CURLDIR)/include
>>> -		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$ 
>>> (lib) -lcurl
>>> +		CURL_LIBCURL = -L$(CURLDIR)/$(lib) -lcurl
>>> +ifndef NO_RPATH
>>> +		CURL_LIBCURL += $(CC_LD_DYNPATH)$(CURLDIR)/$(lib)
>>> +endif
>>>  	else
>>>  		CURL_LIBCURL = -lcurl
>>>  	endif
>>
>>> @@ -539,7 +546,10 @@ endif
>>>
>>>  ifdef ZLIB_PATH
>>>  	BASIC_CFLAGS += -I$(ZLIB_PATH)/include
>>> -	EXTLIBS += -L$(ZLIB_PATH)/$(lib) $(CC_LD_DYNPATH)$(ZLIB_PATH)/$ 
>>> (lib)
>>> +	EXTLIBS += -L$(ZLIB_PATH)/$(lib)
>>> +ifndef NO_RPATH
>>> +	EXTLIBS += $(CC_LD_DYNPATH)$(ZLIB_PATH)/$(lib)
>>> +endif
>>>  endif
>>>  EXTLIBS += -lz
>>>
>>
>> While these parts are ugly but correct, I think...
>>
>>> @@ -547,7 +557,10 @@ ifndef NO_OPENSSL
>>>  	OPENSSL_LIBSSL = -lssl
>>>  	ifdef OPENSSLDIR
>>>  		BASIC_CFLAGS += -I$(OPENSSLDIR)/include
>>> -		OPENSSL_LINK = -L$(OPENSSLDIR)/$(lib) $(CC_LD_DYNPATH)$ 
>>> (OPENSSLDIR)/$(lib)
>>> +		OPENSSL_LINK = -L$(OPENSSLDIR)/$(lib)
>>> +ifndef NO_RPATH
>>> +		OPENSSL_LINK = $(CC_LD_DYNPATH)$(OPENSSLDIR)/$(lib)
>>> +endif
>>>  	else
>>>  		OPENSSL_LINK =
>>>  	endif
>>
>> this and the ICONV one are missing s/=/+=/.
>
> You're right, sorry.
>
>>
>> If we do not care about supporting too old GNU make, we can do
>> this by first adding this near the top:
>>
>>         ifndef NO_RPATH
>>         LINKER_PATH = -L$(1) $(CC_LD_DYNPATH)$(1)
>>         else
>>         LINKER_PATH = -L$(1)
>>         endif
>>
>> and then doing something like:
>>
>> 	CURL_LIBCURL = $(call LINKER_PATH,$(CURLDIR)/$(lib))
>> 	OPENSSL_LINK = $(call LINKER_PATH,$(OPENSSLDIR)/$(lib))
>>
>> to make it easier to read and less error prone.
>>
>
> Yes.  I can rework the patch, but the question is: do you care  
> about old GNU make?  Can I rewrite the patch with this feature?

I know Junio is still offline but maybe someone else has an objection  
against this?

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-3--51782542
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHG8sGwwE67wC8PUkRAn9KAJ9P3wmHa1sKLaQS4GKdoBzyfWZ/SgCeJqcP
KJNL5ak/nrF/8ZRPWrgiBwM=
=nTai
-----END PGP SIGNATURE-----

--Apple-Mail-3--51782542--
