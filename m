From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Add git-archive
Date: Wed, 06 Sep 2006 14:42:49 -0700
Message-ID: <7vac5c7jty.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>
	<7vfyf6ce29.fsf@assigned-by-dhcp.cox.net>
	<44FED12E.7010409@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 23:43:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL5AU-00046F-Qj
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 23:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWIFVmn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 17:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbWIFVmn
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 17:42:43 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:930 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751687AbWIFVmm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 17:42:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060906214241.IUUY6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Sep 2006 17:42:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id K9ii1V00b1kojtg0000000
	Wed, 06 Sep 2006 17:42:42 -0400
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <44FED12E.7010409@innova-card.com> (Franck Bui-Huu's message of
	"Wed, 06 Sep 2006 15:46:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26562>

Franck Bui-Huu <vagabon.xyz@gmail.com> writes:

>>> +typedef int (*parse_extra_args_fn_t)(int argc,
>>> +				     const char **argv,
>>> +				     const char **reason);
>>> +
>> 
>> I do not see a way for parse_extra to record the parameter it
>> successfully parsed, other than in a source-file-global, static
>> variable.  Not a very nice design for a library, if we are
>> building one from scratch.
>
> Interesting, could you explain why static variables are not nice ?

Mostly taste and a little bit of re-entrancy worries.

> You might have missed my second patch:
>
> 		"[PATCH 2/2] Add git-upload-archive"
>
> Basically the server can also use 'reason' to report a failure
> description during NACK. I find it more useful than the simple
> "server sent EOF" error message.

That's a good intention, but we would also need to convey the
"server side found problem and died with these error() output"
anyway, so it would be covered either way (see how error()/die()
messages from git-upload-pack are given to git-fetch-pack over
the wire).

> 'remote' case is not a generic argument that can be passed to
> archiver backends. Remember, the archiver backends only do local
> operation. They do not know about remote protocol which is part
> of git-archive command. That's the reason why I think we shouldn't
> make this field part of arguments structure.

Ok.  Passing that as a separate paramter would make sense.

>> After parse_archive_args finds the archiver specified with
>> --format=*, it can call its parse_extra to retrieve a suitable
>> struct that has struct archive_args embedded at the beginning,
>> and then set remote and prefix on the returned structure.
>
> One bad side is that we need to malloc this embedded structure.

Not at all, if you read the example I did you would notice that
I changed parse_extra for each backend to return this structure
allocated for that particular backend.

>>> +static int run_remote_archiver(struct archiver_struct *ar, int argc,
>>> +			       const char **argv)
>>> +{
>>> +	char *url, buf[1024];
>>> +	pid_t pid;
>>> +	int fd[2];
>>> +	int len, rv;
>>> +
>>> +	sprintf(buf, "git-upload-%s", ar->name);
>> 
>> Are you calling git-upload-{tar,zip,rar,...} here?
>
> yes. Actually git-upload-{tar,zip,...} commands are going to be
> removed, but git-daemon know them as a daemon service.

That would break "git-archive --remove=ssh://site/repo treeish"
wouldn't it?
