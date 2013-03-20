From: Danny Thomas <Danny.Thomas@blackboard.com>
Subject: Re: [PATCH] git-p4: support exclusively locked files
Date: Wed, 20 Mar 2013 07:33:29 -0400
Message-ID: <CD6F44FF.1DFE4%danny.thomas@blackboard.com>
References: <20130319192312.GA16872@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 12:34:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIHHO-0005C8-G3
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 12:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933411Ab3CTLde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 07:33:34 -0400
Received: from exprod8og102.obsmtp.com ([64.18.3.84]:60423 "EHLO
	exprod8og102.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757926Ab3CTLdb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Mar 2013 07:33:31 -0400
Received: from mail1.blackboard.com ([69.196.244.118]) (using TLSv1) by exprod8ob102.postini.com ([64.18.7.12]) with SMTP
	ID DSNKUUmeijkBcwEp9Nw5ZTTZO1CvmoE6amO/@postini.com; Wed, 20 Mar 2013 04:33:31 PDT
Received: from DCEX07-2.bbbb.net ([169.254.1.71]) by DCCAS3.bbbb.net
 ([10.2.224.18]) with mapi; Wed, 20 Mar 2013 07:33:29 -0400
Thread-Topic: [PATCH] git-p4: support exclusively locked files
Thread-Index: Ac4lXr5nr4jMnA8jSwipUEnXrSDmPg==
In-Reply-To: <20130319192312.GA16872@padd.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218586>

Sounds good to me. I've got a couple of busy days coming up, but should
have time this week.

Danny




On 19/03/2013 19:23, "Pete Wyckoff" <pw@padd.com> wrote:

>Danny.Thomas@blackboard.com wrote on Mon, 18 Mar 2013 09:26 -0400:
>> Interesting. 'Implementing sitewide pessimistic locking with p4
>>typemap',
>>
>>http://www.perforce.com/perforce/doc.current/manuals/p4sag/03_superuser.h
>>tm
>> l seems to suggest this is all that's needed. I believe we're using the
>> default configuration, the exclusive lock on all files behaviour was
>> researching the exclusive locking problem,
>> http://ericlathrop.com/2012/12/how-to-set-up-git-p4-in-windows/, so I
>> thought I'd mention it.
>>
>> You might be onto something w/ fstat, it doesn't include the exclusive
>> indicator:
>>
>> ... type binary+l
>>
>> Latest P4 client, and fairly recent server build:
>>
>> P4/DARWIN90X86_64/2012.2/536738 (2012/10/16)
>> P4D/LINUX26X86_64/2012.2/538478 (2012/10/16)
>
>Great, thanks for the pointer and explanation.  Do you want to
>reroll your patch to use fstat?  I'll work on the tests, and
>also look into potential failure modes of "git p4 submit" when somebody
>else has the exclusive file open.
>
>               -- Pete
>
>> On 17/03/2013 20:04, "Pete Wyckoff" <pw@padd.com> wrote:
>>
>> >Danny.Thomas@blackboard.com wrote on Wed, 13 Mar 2013 13:51 -0400:
>> >> By default, newly added binary files are exclusively locked by
>>Perforce:
>> >>
>> >> 'add default change (binary+l) *exclusive*'
>> >>
>> >> This results in a 'Could not determine file type' error as the regex
>> >> expects
>> >> the line to end after the file type matching group. Some repositories
>> >>are
>> >> also configured to always require exclusive locks, so may be a
>>problem
>> >>for
>> >> all revisions in some cases.
>> >
>> >Can you explain how to configure p4d to default everything to
>> >binary+l?  Also, what version are you using ("p4 info")?  I'm
>> >trying to write a test case for this.
>> >
>> >I did find a way to play with typemap to get +l, as:
>> >
>> >    ( p4 typemap -o ; printf "\tbinary+l\t//.../bash*" ) | p4 typemap
>>-i
>> >
>> >With this, the 2011.1 here just says:
>> >0
>> >    tic-git-test$ p4 opened bash
>> >    //depot/bash#1 - add default change (binary+l)
>> >
>> >I've not been able to make it say " *exclusive*" too.
>> >
>> >>      result = p4_read_pipe(["opened", wildcard_encode(file)])
>> >> -    match = re.match(".*\((.+)\)\r?$", result)
>> >> +    match = re.match(".*\((.+)\)(?:.+)?\r?$", result)
>> >
>> >I think this whole function would be less brittle
>> >using p4's "-G" output, like:
>> >
>> >    d = p4Cmd(["fstat", "-T", "type", wildcard_encode(file)])
>> >    # some error checking
>> >    return d['type']
>> >
>> >But I'm curious if your p4d includes " *exclusive*" in the
>> >type there too, in which case we'll have to strip it.
>> >
>> >Thanks for starting the patch on this.  It's good if we can keep
>> >others from running into the same problem.


This email and any attachments may contain confidential and proprietary information of Blackboard that is for the sole use of the intended recipient. If you are not the intended recipient, disclosure, copying, re-distribution or other use of any of this information is strictly prohibited. Please immediately notify the sender and delete this transmission if you received this email in error.
