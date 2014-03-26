From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH 1/4] test-lib: add test_dir_is_empty()
Date: Wed, 26 Mar 2014 09:29:12 +0100
Message-ID: <53328FD8.4050907@web.de>
References: <5331B6F6.60501@web.de> <5331B717.5010600@web.de> <xmqq4n2mknqf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder p <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 09:31:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSjFM-0006dL-Qs
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 09:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbaCZIbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 04:31:33 -0400
Received: from mout.web.de ([212.227.15.3]:53982 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130AbaCZIbb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 04:31:31 -0400
Received: from [192.168.178.41] ([84.132.147.65]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M2dTd-1XKpCO40n7-00sPyQ; Wed, 26 Mar 2014 09:29:14
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqq4n2mknqf.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:TPa/6tTL05+U2d5ThDrF31Wn/QU5CW17JLGxGZoan1fIHq0GznV
 BSPR7NV1L5JDEUohfWJGv13wx9qygg8DB4O9onBR4unRJOq2NQ8cwPZWK44XjQxPRTKc98h
 jcERyR9EVz5q5SPRjPabiGjBHiRBUbb5L/6XlDBnT3NqH21w8I/Frmj79o0Pg6qLFDVUnM0
 p4dP7iZd1ypvDajT2TyrA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245169>

Am 25.03.2014 21:49, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> For the upcoming submodule test framework we often need to assert that an
>> empty directory exists in the work tree. Add the test_dir_is_empty()
>> function which asserts that the given argument is an empty directory.
>>
>> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>> ---
>>
>> I believe this one is pretty straightforward (unless I missed that this
>> functionality already exists someplace I forgot to look ;-).
> 
> I am not very thrilled to see that it depends on "." and ".." to
> always exist, which may be true for all POSIX filesystems, but
> still...

Agreed. I didn't find any one-liners to do that ("ls -A" isn't
POSIX), so I decided to wrap that in a function. Testing that
"rmdir" on the directory succeeds (because the directory is
empty) would kinda work, but then we'd have to re-create the
directory afterwards, which really doesn't sound like a good
strategy either as the test would manipulate the to-be-tested
object. I'm not terribly happy with depending on "." and ".."
either, but couldn't come up with something better. At least
the test should fail for any filesystem not having the dot
files ...

> Do expected callsites of this helper care if "$1" is a symbolic link
> that points at an empty directory?

Yep, a symbolic link pointing to an empty directory should make
the test fail.

> What do expected callsites really want to ensure?  In other words,
> why do they care if the directory is empty?  Is it to make sure,
> after some operation, they can "rmdir" the directory?

To assert that a submodule is created but *not* populated. This
is intended to catch any possible fallout from the recursive
checkout later, in case that would kick in when it shouldn't.

>>  t/test-lib-functions.sh | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>> index 158e10a..93d10cd 100644
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -489,6 +489,17 @@ test_path_is_dir () {
>>  	fi
>>  }
>>
>> +# Check if the directory exists and is empty as expected, barf otherwise.
>> +test_dir_is_empty () {
>> +	test_path_is_dir "$1" &&
>> +	if test $(ls -a1 "$1" | wc -l) != 2
>> +	then
>> +		echo "Directory '$1' is not empty, it contains:"
>> +		ls -la "$1"
>> +		return 1
>> +	fi
>> +}
>> +
>>  test_path_is_missing () {
>>  	if [ -e "$1" ]
>>  	then
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
