From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git-submodule: a small fix
Date: Tue, 27 Sep 2011 09:24:13 +0200
Message-ID: <4E817A1D.8050902@web.de>
References: <CAOOg04z0UjOQCBMTuii37y3ykNU17hDTcD9E81C+r1whFpMaCg@mail.gmail.com> <CAH5451k-6HHx2xxddJauE8=P1umjG=TnrcOKmQfeh=4GOzpCKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andrew Ardill <andrew.ardill@gmail.com>, git@vger.kernel.org
To: Roy Liu <carsomyr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 09:24:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8S1f-0005lL-4a
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 09:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502Ab1I0HYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 03:24:18 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:55562 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab1I0HYR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 03:24:17 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 6EB761AC85E91;
	Tue, 27 Sep 2011 09:24:16 +0200 (CEST)
Received: from [79.247.253.22] (helo=[192.168.178.43])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #2)
	id 1R8S1Y-0006nT-00; Tue, 27 Sep 2011 09:24:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <CAH5451k-6HHx2xxddJauE8=P1umjG=TnrcOKmQfeh=4GOzpCKQ@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18tTyojgnCAGVsh4l3qIeSnreCG0CjA+UI3WqVK
	w5jlvAH1nW+d3T7hPUyIkS43Gw3wAlKwxB+TovqVQYvP9w/xkW
	ALWs6HVInQKR5VEJ1J6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182215>

Am 27.09.2011 05:22, schrieb Andrew Ardill:
> On 27 September 2011 08:00, Roy Liu <carsomyr@gmail.com> wrote:
>> In git-submodule.sh, the "url" variable may contain a stale value from
>> the previous loop iteration, so clear it.
>>
>> --- git-submodule.sh.orig   2011-09-26 17:50:45.000000000 -0400
>> +++ git-submodule.sh    2011-09-26 17:51:18.000000000 -0400
>> @@ -370,6 +370,8 @@
>>            esac
>>            git config submodule."$name".url "$url" ||
>>            die "Failed to register url for submodule path '$path'"
>> +        else
>> +            url=""
>>        fi
>>
>>        # Copy "update" setting when it is not set yet
> 
> Perhaps a better commit description would be:
> 
> git-submodule: clear the url variable when not set to avoid using stale values

Yes, the commit description needs to describe what was changed (and you can
also drop the "git-", to start with "submodule:" is sufficient here). Also
it would be nice if the message would describe under what circumstances this
happens (how did you notice this problem?).

But I wonder if the patch does it the right way. While it fixes the basic
issue that "url" might not be set, I doubt it does what the user expects.
The place where the - sometimes uninitialized - variable "url" is used is
a few lines down:

		say "$(eval_gettext "Submodule '\$name' (\$url) registered for path '\$path'")"

I doesn't make much sense to say "Submodule 'foo' () registered for path 'foo'"
here. Shouldn't "url" be set to "$(git config "submodule.$name.url")"? And
when looking at the if you added the else to it might make sense to set it
unconditionally before the if and then test "$url" there instead of adding an
extra else.
