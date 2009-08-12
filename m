From: Shaun Cutts <shaun@cuttshome.net>
Subject: Re: git index: how does it work?
Date: Wed, 12 Aug 2009 13:52:31 +0200
Message-ID: <436D5ED1-2F0E-4227-AC4A-3A5FD16B2DCF@cuttshome.net>
References: <loom.20090805T160528-69@post.gmane.org> <7v7hxi9m4k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 13:52:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbCNv-0006Ps-DE
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 13:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbZHLLwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 07:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbZHLLwl
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 07:52:41 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:58520 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbZHLLwk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 07:52:40 -0400
Received: (qmail 28753 invoked from network); 12 Aug 2009 11:52:40 -0000
Received: from apn-95-40-196-84.dynamic.gprs.plus.pl (shaunc@[95.40.196.84])
          (envelope-sender <shaun@cuttshome.net>)
          by mail2.sea5.speakeasy.net (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 12 Aug 2009 11:52:37 -0000
In-Reply-To: <7v7hxi9m4k.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125694>

Junio,

Your advice was very helpful.

Digging in, however, I find I still am in the dark on one point: how  
does the index track renamed files, and how to query it for  
information about them?

For instance, if I add a 5th step to the sequence:

5) git mv foo.c bar.c

Then I am told by "git status" that the file is renamed, but I can't  
seem to elict this info using "git ls-files". Under some circumstances  
even "git status" lists a new and deleted file after a rename.

Are renames being tracked by the index, and is there a more basic  
interface than "status" to query about them?

Thanks for any help,
--- Shaun

On Aug 5, 2009, at 8:00 PM, Junio C Hamano wrote:

> Shaun Cutts <shaun@cuttshome.net> writes:
>
>> I am wondering if someone could explain and/or point me to an  
>> explanation of how
>> the git index works.
>>
>> For instance, suppose I have a tracked file: "foo.c"
>>
>> 1) [I modify "foo.c"]
>> 2) git add foo.c
>> 3) [modify again]
>> 4) git commit -m "blah blah"
>>
>> Since I don't include the "-a" switch, the version I added on step  
>> 2 is
>> committed. But how does the index keep track of these changes? Does  
>> the index
>> file actually contain the hunks of "foo.c" that have been modified?  
>> Or is there
>> a "temporary" blob created, which the index points to?
>
> Step 2 hashes foo.c and creates a blob object and registers it to the
> index.  Step 4 writes out the index as a tree and makes a commit out  
> of
> it.
>
> Running this sequence might be instructive.
>
> 	1$ edit foo.c
>        2$ git add foo.c
>        2a$ git ls-files -s foo.c
> 	2b$ git diff foo.c
>        2c$ git diff --cached foo.c
>        3$ edit foo.c
>        3a$ git ls-files -s foo.c
> 	3b$ git diff foo.c
>        3c$ git diff --cached foo.c
>        4$ git commit -m 'half-edit of foo.c'
>        4a$ git ls-files -s foo.c
> 	4b$ git ls-tree HEAD foo.c
>        4c$ git diff foo.c
>        4d$ git diff --cached foo.c
>
> - 2a shows the actual blob object that was created out of foo.c in  
> step 2.
>
> - 2b shows the difference between that blob (now in the index) and  
> foo.c,
>   which should be empty.
>
> - 2c shows the difference between the HEAD commit and the index, which
>   should show your edit in step 1.
>
> - 3a shows the blob in the index; you haven't added, so it should show
>   the same as 2a.
>
> - 3b shows the difference between the index and foo.c, which should  
> show
>   the edit in step 3.
>
> - 3c shows the difference between the HEAD commit and the index, which
>   should show your edit in step 1.
>
> - 4a shows the blob in the index; you haven't added, so it should show
>   the same as 2a.
>
> - 4b shows the blob in the committed tree and the blob object should  
> be
>   identical to 2a.
>
> - 4c shows the difference between the index and foo.c, which should  
> show
>   the edit in step 3.
>
> - 4d shows the difference between the HEAD commit and the index, which
>   should now be empty.
>
