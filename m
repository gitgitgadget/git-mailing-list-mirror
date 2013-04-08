From: Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH 1/2] clone: Fix error message for reference repository
Date: Sun, 7 Apr 2013 20:06:58 -0400
Message-ID: <20130408000658.GG27178@pug.qqx.org>
References: <1365376629-16054-1-git-send-email-aaron@schrab.com>
 <20130407234810.GG19857@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:48:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5ri-0000sy-Th
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934573Ab3DHAHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 20:07:00 -0400
Received: from pug.qqx.org ([50.116.43.67]:33294 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757616Ab3DHAG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 20:06:59 -0400
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 1223A57DE5; Sun,  7 Apr 2013 20:06:59 -0400 (EDT)
Mail-Followup-To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20130407234810.GG19857@elie.Belkin>
User-Agent: Mutt/1.5.21+145 (gd0ebb66) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220388>

At 16:48 -0700 07 Apr 2013, Jonathan Nieder <jrnieder@gmail.com> wrote:
>Hi Aaron,

Thanks for the feedback.

>Aaron Schrab wrote:
>
>> Do not report an argument to clone's --reference option is not a local
>> directory.  Nothing checks for the actual directory so we have no way to
>> know if whether or not exists.  Telling the user that a directory doesn't
>> exist when that isn't actually known may lead him or her on the wrong
>> path to finding the problem.
>
>I don't understand the above explanation.  Could you give an example?

I originally noticed this while trying to use a submodule as a reference 
repository.  Since that submodule was first checked out using a recent 
version of git it used a .git file rather than having a .git directory.  
This caused the checks to fail, and the misleading error message had me 
checking for a typo in the path which I'd supplied.

I'll attempt to clarify that message in the next version.

>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -241,7 +241,7 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
>>  		free(ref_git);
>>  		ref_git = ref_git_git;
>>  	} else if (!is_directory(mkpath("%s/objects", ref_git)))
>> -		die(_("reference repository '%s' is not a local directory."),
>> +		die(_("reference repository '%s' is not a local repository."),
>
>"is_directory" calls stat and checks if its target is a directory.  Is
>the problem that "/path/to/repo.git" might be a directory but
>"/path/to/repo.git/objects" may not?

In my case the issue was that /path/to/repo is a directory, but 
/path/to/repo/.git/objects (which is checked shortly before the above 
context) didn't exist since /path/to/repo/.git is a file.

>Would it make sense for the message to say something like the
>following?
>
>	fatal: alternate object store '/path/to/repo.git/objects' is not a local directory

That would also avoid lying to the user.  But if combined with the 
second patch in this series it could cause confusion for a different 
reason.  Once .git files are honored, the path reported there may have 
no relation to the path supplied by the user.
