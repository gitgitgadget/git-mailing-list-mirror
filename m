From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/7] Simplify strbuf uses in archive-tar.c using the 
  proper functions.
Date: Fri, 07 Sep 2007 00:54:39 +0200
Message-ID: <46E0852F.4090005@lsrfire.ath.cx>
References: <20070902224213.GB431@artemis.corp> <11890776114037-git-send-email-madcoder@debian.org> <118907761140-git-send-email-madcoder@debian.org> <11890776111843-git-send-email-madcoder@debian.org> <1189101569.3423.17.camel@hinata.boston.redhat.com> <20070906180858.GJ8451@artemis.corp> <1189102714.3423.22.camel@hinata.boston.redhat.com> <20070906182746.GK8451@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 00:54:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITQFP-00077e-4i
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 00:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbXIFWyq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 6 Sep 2007 18:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756375AbXIFWyq
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 18:54:46 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:59108
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753859AbXIFWyp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 18:54:45 -0400
Received: from [10.0.1.201] (p508ED793.dip.t-dialin.net [80.142.215.147])
	by neapel230.server4you.de (Postfix) with ESMTP id C4773873B5;
	Fri,  7 Sep 2007 00:54:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20070906182746.GK8451@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57940>

Pierre Habouzit schrieb:
> On Thu, Sep 06, 2007 at 06:18:34PM +0000, Kristian H=F8gsberg wrote:
>> On Thu, 2007-09-06 at 20:08 +0200, Pierre Habouzit wrote:
>>> On Thu, Sep 06, 2007 at 05:59:29PM +0000, Kristian H=F8gsberg wrote=
:
>>>> On Thu, 2007-09-06 at 13:20 +0200, Pierre Habouzit wrote:
>>>>> -	memcpy(path.buf, base, baselen);
>>>>> -	memcpy(path.buf + baselen, filename, filenamelen);
>>>>> -	path.len =3D baselen + filenamelen;
>>>>> -	path.buf[path.len] =3D '\0';
>>>>> +	strbuf_grow(&path, MAX(PATH_MAX, baselen + filenamelen + 1));
>>>>> +	strbuf_reset(&path);
>>>> Does strbuf_reset() do anything here?
>>>>
>>>>> +	strbuf_add(&path, base, baselen);
>>>   Yes _reset() sets length to 0. so the add here will write at the =
start
>>> of the buffer again. It definitely is important !
>> But where was length set to non-zero?  path is initialized on entry =
to
>> the function, and strbuf_grow() just increases the allocation, not
>> length, right?
>=20
>   The path is static, hence when you reenter the function you have th=
e
> last value in it. The fact that it's static may be questionable, but =
it
> was like it before, I kept it, I've supposed it was for performance
> reasons.

You're right, I've made it static to get the number of mallocs from
number-of-files-in-archive down to one.  It was a ~10% speedup in the
warm cache case, so I could not resist. :)

Ren=E9
