From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git attributes ignored for root directory
Date: Wed, 05 Oct 2011 14:05:46 +0200
Message-ID: <4E8C481A.1070808@alum.mit.edu>
References: <4E8B55FB.1050203@svario.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gioele Barabucci <gioele@svario.it>
X-From: git-owner@vger.kernel.org Wed Oct 05 14:05:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBQEX-0007MF-JP
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 14:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934429Ab1JEMFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 08:05:52 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:50113 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934286Ab1JEMFv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 08:05:51 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p95C5lan005095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 5 Oct 2011 14:05:47 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <4E8B55FB.1050203@svario.it>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182840>

On 10/04/2011 08:52 PM, Gioele Barabucci wrote:
> I just updated to git v1.7.7 using the Ubuntu Lucid PPA and I found that
> `git check-attr` is broken now.
> 
> I have this attribute in my `$HOME/.gitattributes` file:
> 
>     /. show_in_prompt=no
> 
> Now, if I go to `$HOME` and run
> 
>     git check-attr show_in_prompt -- .
> 
> With git v1.7.6 this is the answer I got:
> 
>     .: show_in_prompt: no
> 
> With the newer v1.7.7 I get this, instead:
> 
>     .: show_in_prompt: unspecified
> 
> Also, if I use the `--all` option, `check-attr` does not show any
> attribute at all.
> 
> I see in the release notes of 1.7.7-rc1 that `check-attr` has been
> changed to allow relative paths to be specified. Maybe this error is
> related to that change.

Indeed, your use case is broken by

f5114a40c0d0276ce6ff215a3dc51eb19da5b420

In fact the support for gitattributes using patterns involving "." was
pretty spotty in v1.7.6 too.  For example,

-------------------------------------------
echo ". foo" >./.gitattributes
git check-attr foo -- . ./ ./. x x/ ./x x/.
.: foo: set
./: foo: unspecified      WRONG
./.: foo: set
x: foo: unspecified       WRONG?
x/: foo: unspecified      WRONG?
./x: foo: unspecified     WRONG?
x/.: foo: set             RIGHT?

-------------------------------------------
echo "/. foo" >./.gitattributes
git check-attr foo -- . ./ ./. x x/ ./x x/.
.: foo: set
./: foo: unspecified      WRONG
./.: foo: set
x: foo: unspecified
x/: foo: unspecified
./x: foo: unspecified
x/.: foo: unspecified

-------------------------------------------
echo ". foo" >x/.gitattributes
git check-attr foo -- . ./ ./. x x/ ./x x/.
.: foo: unspecified
./: foo: unspecified
./.: foo: unspecified
x: foo: unspecified       WRONG?
x/: foo: unspecified      WRONG?
./x: foo: unspecified     WRONG?
x/.: foo: set             RIGHT?

-------------------------------------------
echo "/. foo" >x/.gitattributes
git check-attr foo -- . ./ ./. x x/ ./x x/.
.: foo: unspecified
./: foo: unspecified
./.: foo: unspecified
x: foo: unspecified       WRONG
x/: foo: unspecified      WRONG
./x: foo: unspecified     WRONG
x/.: foo: set

-------------------------------------------

I conclude that this functionality was never really defined correctly,
and you were pretty lucky that your case worked at all :-)

It's not to hard to fix your particular use case.  But for a real fix,
we would need to decide what is the correct behavior in all of the lines
above marked "?"; specifically, should "." match every subdirectory
under a given directory, does it match only the directory containing the
.gitattributes file, or is this construct illegal?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
