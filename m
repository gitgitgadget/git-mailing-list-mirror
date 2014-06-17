From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 0/3] add strnncmp() function
Date: Tue, 17 Jun 2014 13:08:05 +0200
Message-ID: <53A02195.8080202@web.de>
References: <cover.1402990051.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 13:08:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwrFP-0008Ha-7M
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 13:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbaFQLIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 07:08:09 -0400
Received: from mout.web.de ([212.227.17.12]:49213 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755771AbaFQLIH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 07:08:07 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MZUWH-1XI71X1KGb-00LEfU; Tue, 17 Jun 2014 13:08:06
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <cover.1402990051.git.jmmahler@gmail.com>
X-Provags-ID: V03:K0:HfI2Uo6niDsrRWj8lay8PyosoZ++38hEoUvhzNdpW5JBXXJtw2t
 +UHi/4pb6fqQpKaplnmBi6+a472lmQH1qDHlDuqO75TMIPSmusGhvANx2lT15O1rRxcSswl
 Ro64KFUw7+lW2Iio2dellB94svWlHZarnBI7oJETCweAHGpon02Vuom7d7jLTw64pPM8bEv
 +MkOVq2ql8oy5pbJEUtdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251860>

On 2014-06-17 09.34, Jeremiah Mahler wrote:
> Add a strnncmp() function which behaves like strncmp() except it takes
> the length of both strings instead of just one.
> 
> Then simplify tree-walk.c and unpack-trees.c using this new function.
> Replace all occurrences of name_compare() with strnncmp().  Remove
> name_compare(), which they both had identical copies of.
> 
> Version 2 includes suggestions from Jonathan Neider [1]:
> 
>   - Fix the logic which caused the new strnncmp() to behave differently
> 	from the old version.  Now it is identical to strncmp().
> 
>   - Improve description of strnncmp().
> 
> Also, strnncmp() was switched from using memcmp() to strncmp()
> internally to make it clear that this is meant for strings, not
> general buffers.
I don't think this is a good change, for 2 reasons:
- It changes the semantics of existing code, which should be carefully
  reviewed, documented and may be put into a seperate commit.
- Looking into the code for memcmp() and strncmp() in libc,
  I can see that memcmp() is written in 13 lines of assembler,
  (on a 386 system) with a fast
    repz cmpsb %es:(%edi),%ds:(%esi)
  working as the core engine.
  
  strncmp() uses 83 lines of assembler, because after each comparison
  the code needs to check of the '\0' in both strings.
- I can't see a reason to replace efficient code with less efficient code,
  so moving the old function "as is" into a include file, and declare
  it "static inline" could be the first step.

  Having code inline may open the door for the compiler to decide,
  "Oh, I know exactly what memcmp() does, so I through in a handfull
  of lines assembly code, instead of calling memcmp() from libc".


And another thing:
 What does cache_name_compare(name, namelen, ce->name, len))
 in name-hash.c do?
 Isn't that the same function ?

I like strnncmp() better than 
cache_name_compare() or name_compare(),
but I agree with Erik here that strnncmp() has the potential to
become a name clash some day, so that git_strnncmp() may be better.

Thanks for the effort, cleaning up is needed.


  
