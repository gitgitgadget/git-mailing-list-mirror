From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Wed, 25 Jun 2014 22:23:06 +0200
Message-ID: <53AB2FAA.0@gmail.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>	<53A84077.4010200@ramsay1.demon.co.uk>	<xmqqsimv9pjx.fsf@gitster.dls.corp.google.com>	<53A99FEB.5040808@ramsay1.demon.co.uk> <xmqq61joamcc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:23:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wztir-0000Y2-EP
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 22:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbaFYUXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 16:23:08 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:56673 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932426AbaFYUXH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 16:23:07 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi2so3150831wib.1
        for <git@vger.kernel.org>; Wed, 25 Jun 2014 13:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=eyxv04qyIcvNTXuvRLq5QF+SmHM1r/ezZ3D9lJA0vNU=;
        b=oWh4P44Ni7ipx4efSJySGhbtnR0V6iKrGbV4XAFjuRq3VZG/j7QTiW+mxPD2kLD8J+
         GLYXlX+JOchPQQsnqTMLyLq4bE88YE0ZsB4zi53rerGh3dEEKb5NcyXKACgmO9v50WBW
         81/cguRK0230in9CGodVKdlM5r+X8t/d/QFI9VIJMM9rb46nF8PGR0Lx3jHsn3jdMF6b
         zCa0NBiTUMYTxds7Qqxic7qORcHygXdZGH12IM+F+GcMlGNM/lZjOwSNyS5nPQZ5NyrM
         kcE18JKfFXuSWUB3zyk885q1VW34eI748mpMivAaFFG0kuoLJ1z/PrvpObTk3Xbyda12
         STQw==
X-Received: by 10.194.57.132 with SMTP id i4mr12197229wjq.6.1403727785481;
        Wed, 25 Jun 2014 13:23:05 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id i4sm15971059wib.21.2014.06.25.13.23.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 13:23:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq61joamcc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252456>

Am 25.06.2014 20:13, schrieb Junio C Hamano:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> On 24/06/14 00:25, Junio C Hamano wrote:
>> ...
>>> Yup, that is a very good point.  There needs an infrastructure to
>>> tie a set of files (i.e. the standard one being the chain of
>>> system-global /etc/gitconfig to repo-specific .git/config, and any
>>> custom one that can be specified by the caller like submodule code)
>>> to a separate hashmap; a future built-in submodule code would use
>>> two hashmaps aka "config-caches", one to manage the usual
>>> "configuration" and the other to manage the contents of the
>>> .gitmodules file.
>>>
>>
>> I had expected to see one hash table per file/blob, with the three
>> standard config hash tables linked together to implement the scope/
>> priority rules. (Well, these could be merged into one, as the current
>> code does, since that makes handling "multi" keys slightly easier).
> 
> Again, good point.  I think a rough outline of a design that take
> both
> 
>  (1) we may have to read two or more separate sets of "config like
>      things" (e.g. the contents from the normal config system and
>      the contents from the .gitmodules file) and
> 
>  (2) we may have to read two or more files that make up a logically
>      single set of "config-like things" (e.g. the "normal config
>      system" reads from three separate files)
> 
> into account may look like this:
> 
>  * Each instance of in-core "config-like things" is expressed as a
>    struct "config-set".
> 
>  * A "config-set" points at an ordered set of struct "config-file",
>    each of which represents what was read and cached in-core from a
>    file.

Is this additional complexity really necessary?

How would you handle included files? Split up the including file in before / after parts? I.e.

  repo-config-file[include-to-end]
  included-file
  repo-config-file[top-to-include]
  user-config-file
  ...

Looking up a single-valued key would then be O(n) (where n is the number of sruct config_file's in the config_set) rather than O(1).

Looking up a multi-valued key would involve joining values from all files, every time the value is looked up (dynamically allocating lists on the heap etc.).

The configuration is typically loaded once, followed by lots of lookups. So from a performance perspective, doing the merging at load time is sure better.

> 
>  * When we know or notice that a single file on the filesystem was
>    modified, we do not have to invalidate the whole "config-set"
>    that depends on the file; the "config-file" that corresponds to
>    the file on the filesystem is invalidated instead.
> 

What's the use case for this? Do you expect e.g. 'git gc' to detect changed depth/window size at run time and adjust the algorithm accordingly? Or do you just intend to cache parsed config data (the latter could be done by recording all involved file names and stats in the config-set and reloading the whole thing if any of the files change)?
