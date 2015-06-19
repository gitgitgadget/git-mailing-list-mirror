From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 00/19] Introduce an internal API to interact with the
 fsck machinery
Date: Fri, 19 Jun 2015 21:43:05 +0200
Organization: gmx
Message-ID: <8eb30cab0d359420bc037ab89b21c4b3@www.dscho.org>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
 <cover.1434657920.git.johannes.schindelin@gmx.de>
 <xmqq8ubgd5vt.fsf@gitster.dls.corp.google.com>
 <e3f2c023e59c3608ebbb7e88a6f18d27@www.dscho.org>
 <xmqqfv5na9hd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 21:43:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z62CI-0002Km-2Y
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 21:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbbFSTn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 15:43:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:62050 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034AbbFSTnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 15:43:25 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MK4fR-1Z5DNR0c1l-001Uw4; Fri, 19 Jun 2015 21:43:08
 +0200
In-Reply-To: <xmqqfv5na9hd.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:060UKzZ0Gw0rL7UyWguXDfj4Gdva3XVNhAS73rnijwMQ7MGj6nb
 AeVKK9cXeGskqwkaBXqBZfEqAipTcrsGPBBs9OpYD2OyIXXp00D3lAAn8+/z2tjlApiJ+3d
 DXwi0wSX8kA5JhTO+eGXZBX8cbo9+XFK+mLe+lysEx0XsVs6qGDBuvjvUIIHE5BuXLjIbp4
 EPJsnch4J9dnJTuJEiN4Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272190>

Hi Junio,

first of all: the improvements discussed here are already part of v6.

On 2015-06-19 19:33, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> I basically made up names on the go, based on the messages.
>>
>>> Some of the questionable groups are:
>>>
>>>     BAD_DATE DATE_OVERFLOW
>>
>> I guess it should be BAD_DATE_OVERFLOW to be more consistent?
> 
> I am not sure about "consistency", but surely a common prefix would
> help readers to group things.  But for this particular group, I was
> wondering if singling out "integer overflow", "zero stuffed
> timestamp", etc. into such a finer sub-errors of "you have a bad
> timestamp" was beneficial.

Well, someone thought it a good idea to print different error messages, and I took that as an indicator that there is merit in being able to distinguish these issues from one another.
 
>>>     BAD_TREE_SHA1 INVALID_OBJECT_SHA1 INVALID_TREE
>>>
>>>     BAD_PARENT_SHA1 INVALID_OBJECT_SHA1
>>
>> So how about s/INVALID_/BAD_/g?
> 
> It is not just about distinction between INVAID and BAD.
> 
> I was basically wondering what rule decides which one among
> BAD_TREE_SHA1, INVALID_OBJECT_SHA1 and INVALID_TREE I would get when
> I have a random non-hexdigit string in various places, e.g. after
> 'tree ' in the object header of a commit object, after 'tag ' in a
> tag object that says 'type tree', etc.

To be honest, I think the IDs do not really matter as much as your comment makes it sound: the IDs purpose is solely to be able to configure the message type (read: whether to error out, warn or ignore the issue). The real information is in the actual message (and I did not change any message, therefore I could not make things worse than they are right now).

Example: you would never read BAD_TREE_SHA1, but instead: "badtreesha1: invalid 'tree' line format - bad sha1".

For BAD_OBJECT_SHA1 (as it is now called), there are actually two code paths generating the error: "invalid 'object' line format - bad sha1" and "no valid object to fsck".

And for BAD_TREE it is: "could not load commit's tree <SHA1>".

Thus, from the error message it should be really clear what is going on.

>>> Also it is unclear if NOT_SORTED is to be used ever for any error
>>> other than a tree object sorted incorrectly, or if we start noticing
>>> a new error that something is not sorted, we will reuse this one.
>>
>> s/NOT_SORTED/TREE_&/ maybe?
> 
> If that error is specific to tree sorting order, then that would be
> a definite improvement.

Yes, that is the case. Tree objects are assumed to list their contents in order, and this ID applies to the problem where a tree object's list is out of order.

As I said, I already made both discussed changes part of v6.

Ciao,
Dscho
