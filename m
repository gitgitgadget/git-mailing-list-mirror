From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] use xread where we are not checking for EAGAIN/EINTR
Date: Mon, 08 Jan 2007 15:56:15 +0000
Message-ID: <45A2699F.5060100@shadowen.org>
References: <1cb8699724ff000fbf0c14ba3e15031e@pinky> <7vvejlg1pg.fsf@assigned-by-dhcp.cox.net> <459E4270.9090307@shadowen.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070703040301050106020909"
Cc: Andy Whitcroft <apw@shadowen.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 16:56:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3wrP-0000p7-5x
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 16:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbXAHP4V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 10:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbXAHP4V
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 10:56:21 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:4558 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbXAHP4S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 10:56:18 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H3wqH-00074V-I1; Mon, 08 Jan 2007 15:55:21 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <459E4270.9090307@shadowen.org>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36267>

This is a multi-part message in MIME format.
--------------070703040301050106020909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andy Whitcroft wrote:
> Junio C Hamano wrote:
>> Andy Whitcroft <apw@shadowen.org> writes:
>>
>>>     We have an xread() wrapper to help us with those nasty
>>>     interrupt returns and yet we fail to use it consistently.
>>>     This patch updates those plain read()'s which do not
>>>     have any handling for errors, or which treat those errors
>>>     as user visible fatal errors.
>>>
>>>     This feels right to me, but perhaps there is some good
>>>     reason that things are done this way ... if so could
>>>     someone elighten me.
>> Thanks.
>>
>> I do not think any of the changes you did introduced new bugs,
>> but I think some of them are still wrong.  xread() protects us
>> from EINTR happening before any byte is read, but it can still
>> give a short read.  Many callers have a loop like this:
>>
>> 	do {
>>         	size = xread(...);
>>                 yet_to_go -= size;
>> 	} while (yet_to_go);
>>
>> but some are not (e.g. add_excludes_from_file_1() in dir.c
>> expects xread() does not return before reading full buffer).
> 
> Yes, that is true.  I was going to fix that in the next step with the
> writes.  But yes thats likely to involve them becoming 'read_in_full'
> style thing and in fact churn us more.
> 
> Ignore this one and I'll look to do it 'right'.

Ok, after much hacking about I think I've got something sensible sorted
out for this.  Following this email are four patches which convert the
various read/write/xread/xwrite users over to xread/read_in_full and
xwrite/write_in_full as appropriate.  Its pretty invasive as obviously
I/O is pretty common in an SCM.

next with this stack passes the builtin test suite.  I additionally used
the attached patch to induce severe short read/write semantics.  Before
this patch series git was _very_ unhappy, unable to even create a
repository.

This series is against next.

-apw


--------------070703040301050106020909
Content-Type: text/plain;
 name="PATCH"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="PATCH"

diff --git a/git-compat-util.h b/git-compat-util.h
index 55456da..931cbed 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -210,6 +210,7 @@ static inline void *xmmap(void *start, size_t length,
 static inline ssize_t xread(int fd, void *buf, size_t len)
 {
 	ssize_t nr;
+	if (len > 5) len = 5;
 	while (1) {
 		nr = read(fd, buf, len);
 		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
@@ -221,6 +222,7 @@ static inline ssize_t xread(int fd, void *buf, size_t len)
 static inline ssize_t xwrite(int fd, const void *buf, size_t len)
 {
 	ssize_t nr;
+	if (len > 5) len = 5;
 	while (1) {
 		nr = write(fd, buf, len);
 		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))

--------------070703040301050106020909--
