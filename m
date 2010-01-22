From: David Rydh <dary@math.berkeley.edu>
Subject: Re: [PATCH] git-mv: Fix error with multiple sources.
Date: Fri, 22 Jan 2010 08:41:59 -0800
Message-ID: <28E55A63-C40D-4C5D-906F-742AC6FC9A88@math.berkeley.edu>
References: <718290.769818367-sendEmail@darysmbp> <7v8wbqbs26.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 17:42:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYMaJ-00052N-Kk
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 17:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753Ab0AVQmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 11:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754696Ab0AVQmI
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 11:42:08 -0500
Received: from cm04fe.IST.Berkeley.EDU ([169.229.218.145]:47922 "EHLO
	cm04fe.IST.Berkeley.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673Ab0AVQmG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 11:42:06 -0500
Received: from [10.136.1.127]
	by cm04fe.ist.berkeley.edu with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(auth plain:dary@math.berkeley.edu)
	(envelope-from <dary@math.berkeley.edu>)
	id 1NYMa8-0001a9-FY; Fri, 22 Jan 2010 08:42:02 -0800
In-Reply-To: <7v8wbqbs26.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137766>

On Jan 21, 2010, at 9:57 PM, Junio C Hamano wrote:

>> diff --git a/setup.c b/setup.c
>> index 710e2f3..80cf535 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -132,8 +132,8 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
>> 		return NULL;
>> 
>> 	if (!entry) {
>> -		static const char *spec[2];
>> -		spec[0] = prefix;
>> +		const char **spec = xmalloc(sizeof(char *) * 2);
>> +		spec[0] = xstrdup(prefix);
>> 		spec[1] = NULL;
>> 		return spec;
>> 	}
> 
> I don't understand this change.  Because elements of returned pathspec
> from this function are often simply the pathspec argument itself (which in
> turn is often argv[] of the calling program), and other times allocated by
> this function, the callers are never going to free() them.

The xstrdup of prefix is for good measure. The important change is the removal of the static spec-array. Two invocations of get_pathspec with different prefixes could invalidate the contents of a pathspec in use.

When called with a non-empty pathspec, all the entries are allocated so I think it is reasonable to allocate them in the degenerate case as well. My impression of the git-code is that it is leaking quite a bit when it comes to strings anyway.
