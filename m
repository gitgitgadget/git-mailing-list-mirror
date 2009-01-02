From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: Handle actions with no project in evaluate_path_info
Date: Fri, 2 Jan 2009 13:09:29 +0100
Message-ID: <cb7bb73a0901020409u304e6344x13b6090732c2d5cd@mail.gmail.com>
References: <a899d7ef0812272326j1a407c30k936bf8d8975c9063@mail.gmail.com>
	 <200901020058.30748.jnareb@gmail.com>
	 <cb7bb73a0901011646n6a1368caq797a5f2849daec77@mail.gmail.com>
	 <a899d7ef0901011821x166f173dx47bdb41326391696@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Devin Doucette" <devin@doucette.cc>
X-From: git-owner@vger.kernel.org Fri Jan 02 13:11:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIirn-0000BG-BB
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 13:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757407AbZABMJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 07:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757384AbZABMJe
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 07:09:34 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:40122 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757345AbZABMJd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 07:09:33 -0500
Received: by ewy10 with SMTP id 10so6727549ewy.13
        for <git@vger.kernel.org>; Fri, 02 Jan 2009 04:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3YNyguuysTnrmbHBITzMU/1EJA8ED7N405qB2NzIyIw=;
        b=ozc31sQOB62gpKMz2F9hLHhg7iB/p/4gKKVLHUYYgMwtxWn1XRK/MZ9G5s8ktxd3fH
         nlqvWd5t3x3QvbPHvB1RGrd1l80LrRbZq6HWfehzKFw0+K2hEqthQyg8uZxdG1Q+vF3g
         jU9BqtOEpoRB/b9A8FFAXlGXuU8l4ItaIHYd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AjhIjK2owvqX4eWbK6OE3w6x8LI+0naBZHRQtlNVL4sPhpJl3gajwzwDjSO+d1XACQ
         UOyzVmzigMIimG5wXKK9DJsGKg7Km0OMQxcgrNI1Al1hZ8s1Tz0d91BZq344Isbr0Tmd
         ZRpEdt8RYpH2BwHRCBPmDp201KdN1DTAeofd4=
Received: by 10.210.109.10 with SMTP id h10mr20783871ebc.154.1230898169668;
        Fri, 02 Jan 2009 04:09:29 -0800 (PST)
Received: by 10.210.72.3 with HTTP; Fri, 2 Jan 2009 04:09:29 -0800 (PST)
In-Reply-To: <a899d7ef0901011821x166f173dx47bdb41326391696@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104374>

On Fri, Jan 2, 2009 at 3:21 AM, Devin Doucette <devin@doucette.cc> wrote:
> On Thu, Jan 1, 2009 at 5:46 PM, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>> Actually, the early bailout was sort of intentional. The problem is
>> the ambiguity: does git.example.com/opml refer to the opml project, or
>> does it refer to the opml action?
>
> Good point. Though my patch does not break any existing functionality,
> it does not fix the case where a project matches the action.
>
>> HOWEVER, href() *does* create the opml action as git.example.com/opml,
>> so gitweb is currently broken in the sense that ti doesn't correctly
>> parse its own pathinfo output. So the question is: shall we go with
>> this patch, preventing pathinfo from working for projects named like a
>> no-project gitweb action, or should we fix href() to not generate
>> pathinfo unless project is defined?
>
> A variation of the latter approach is to modify href() to use pathinfo
> if there is a project or there is no project matching the name of the
> action. The only downside to this approach is that a URI that refers to
> an action when first generated could resolve to a project in the future,
> if a project of the same name were added.

And don't forget the case of a new action being introduced which is
named like an existing project.

I suspect we'd be much better off by not using pathinfo at all for
global actions. Other possible solutions would be to have something
like an ADDITIONAL prefix to the path (like project/projectname vs
action/actionname, so we would have git.example.com/action/opml or
git.example.com/project/example-project) but this is WAY too verbose.

At most, we could add a suffix to global actions to reduce the chance
of name conflict, such as using

git.example.com/opml.xml

or

git.example.com/project_index.txt

but I don't like these solution either: I'd rather have these be
provided as filenames in the response header.

Incoming patch to not make use of path_info without project.


-- 
Giuseppe "Oblomov" Bilotta
