From: Danny Thomas <Danny.Thomas@blackboard.com>
Subject: Re: [PATCH] git-p4: support exclusively locked files
Date: Mon, 18 Mar 2013 09:26:18 -0400
Message-ID: <CD6CC10C.1DE4E%danny.thomas@blackboard.com>
References: <20130317200437.GA29115@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 14:26:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHa5X-0003xX-6U
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 14:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123Ab3CRN0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 09:26:22 -0400
Received: from exprod8og119.obsmtp.com ([64.18.3.38]:50492 "EHLO
	exprod8og119.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab3CRN0V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Mar 2013 09:26:21 -0400
Received: from mail1.blackboard.com ([69.196.244.54]) (using TLSv1) by exprod8ob119.postini.com ([64.18.7.12]) with SMTP
	ID DSNKUUcV/KRTmaoRCULqbGzNHyNgWWA29IAD@postini.com; Mon, 18 Mar 2013 06:26:21 PDT
Received: from DCEX07-2.bbbb.net ([169.254.1.71]) by dccas1 ([10.103.2.71])
 with mapi; Mon, 18 Mar 2013 09:26:19 -0400
Thread-Topic: [PATCH] git-p4: support exclusively locked files
Thread-Index: Ac4j3C0gvYhtN//RSz+9q/8aY6NgNg==
In-Reply-To: <20130317200437.GA29115@padd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.3.2.130206
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218415>

Interesting. 'Implementing sitewide pessimistic locking with p4 typemap',
http://www.perforce.com/perforce/doc.current/manuals/p4sag/03_superuser.htm
l seems to suggest this is all that's needed. I believe we're using the
default configuration, the exclusive lock on all files behaviour was
researching the exclusive locking problem,
http://ericlathrop.com/2012/12/how-to-set-up-git-p4-in-windows/, so I
thought I'd mention it.

You might be onto something w/ fstat, it doesn't include the exclusive
indicator:

... type binary+l

Latest P4 client, and fairly recent server build:

P4/DARWIN90X86_64/2012.2/536738 (2012/10/16)
P4D/LINUX26X86_64/2012.2/538478 (2012/10/16)


Danny

On 17/03/2013 20:04, "Pete Wyckoff" <pw@padd.com> wrote:


>Danny.Thomas@blackboard.com wrote on Wed, 13 Mar 2013 13:51 -0400:
>> By default, newly added binary files are exclusively locked by Perforce:
>>
>> 'add default change (binary+l) *exclusive*'
>>
>> This results in a 'Could not determine file type' error as the regex
>> expects
>> the line to end after the file type matching group. Some repositories
>>are
>> also configured to always require exclusive locks, so may be a problem
>>for
>> all revisions in some cases.
>
>Can you explain how to configure p4d to default everything to
>binary+l?  Also, what version are you using ("p4 info")?  I'm
>trying to write a test case for this.
>
>I did find a way to play with typemap to get +l, as:
>
>    ( p4 typemap -o ; printf "\tbinary+l\t//.../bash*" ) | p4 typemap -i
>
>With this, the 2011.1 here just says:
>0
>    tic-git-test$ p4 opened bash
>    //depot/bash#1 - add default change (binary+l)
>
>I've not been able to make it say " *exclusive*" too.
>
>>      result = p4_read_pipe(["opened", wildcard_encode(file)])
>> -    match = re.match(".*\((.+)\)\r?$", result)
>> +    match = re.match(".*\((.+)\)(?:.+)?\r?$", result)
>
>I think this whole function would be less brittle
>using p4's "-G" output, like:
>
>    d = p4Cmd(["fstat", "-T", "type", wildcard_encode(file)])
>    # some error checking
>    return d['type']
>
>But I'm curious if your p4d includes " *exclusive*" in the
>type there too, in which case we'll have to strip it.
>
>Thanks for starting the patch on this.  It's good if we can keep
>others from running into the same problem.
>
>               -- Pete


This email and any attachments may contain confidential and proprietary information of Blackboard that is for the sole use of the intended recipient. If you are not the intended recipient, disclosure, copying, re-distribution or other use of any of this information is strictly prohibited. Please immediately notify the sender and delete this transmission if you received this email in error.
