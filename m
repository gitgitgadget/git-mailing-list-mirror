From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Deleting of the specified ref during the post-receive hook
Date: Tue, 21 Sep 2010 09:55:04 -0600
Message-ID: <4C98D558.9090900@workspacewhiz.com>
References: <4C98C3F2.9050006@workspacewhiz.com> <20100921145014.GH32601@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 21 17:55:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy5Bg-00035y-Tc
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 17:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757432Ab0IUPzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 11:55:11 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:54830 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756837Ab0IUPzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 11:55:09 -0400
Received: (qmail 7670 invoked by uid 399); 21 Sep 2010 09:55:07 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.196.198.56)
  by hsmail.qwknetllc.com with ESMTPAM; 21 Sep 2010 09:55:07 -0600
X-Originating-IP: 75.196.198.56
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100825 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <20100921145014.GH32601@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156730>

  ----- Original Message -----
From: Shawn O. Pearce
Date: 9/21/2010 8:50 AM
> Joshua Jensen<jjensen@workspacewhiz.com>  wrote:
>> My current line of thought has an auto-merging script that monitors the
>> refs/for/ namespace (similar to Gerrit) and then applies --no-ff merges
>> to the appropriate branch.  For instance, when the user pushes to
>> refs/for/master, the post-receive hook creates a secondary ref called
>> refs/for/master-SHA1-timestamp and then deletes the refs/for/master ref
>>
> FWIW, you don't need `` around the git update-ref calls, because you
> aren't using the output of the command as input to another command.
You are right.  I believe I was early on, and it just got copied and 
pasted around.
> No.  If there are two concurrent pushes occurring, the script may
> execute in parallel.
Okay, so what I'm doing is bad.  Got it.
> But you'll actually get something much worse.  receive-pack will
> create refs/for/master for the first user... and then might be put
> to sleep while another user's receive-pack starts.  That second
> user will see refs/for/master existing, and will fail their push
> because their concept of $newrev doesn't match what is currently
> at refs/for/master.  Then the first user wakes up, runs your
> post-receive, and the ref is cleared.
Yep, this is exactly what I was trying to avoid by deleting the ref.
> The better strategy would be to use an update hook that refuses to
> permit the creation of refs/for/master:
>
>    #!/bin/sh
>    ref=$1
>    old=$2
>    new=$3
>
>    case $ref in
>    refs/for/*)
>      timestamp=`date +%s`
>      git update-ref $ref-$new-$timestamp $new
>      echo "Created $ref-$new-$timestamp"
>      exit 1
>      ;;
>    *)
>      exit 0
>      ;;
>    esac
>
>
> By exit 1 here we refuse the push attempt, so receive-pack won't
> create refs/for/master, and another user pushing won't see that
> false failure.  However, unlike with Gerrit, every user is now going
> to receive a push failure message because the hook has appeared to
> reject the value, even though it accepted it.
Okay, I'll try this.  I can train people in the push failure, if 
necessary.  Thanks!

>> Before I go too much deeper down this path, am I way off base here?
> I'd have to ask why you are using gitolite and trying to abuse
> git-receive-pack to do something that Gerrit does out of the box...
>
Oh, how I would love to just leave it to Gerrit to handle this.  (I 
*really* like Gerrit.)  If you would like to just skip ahead, the actual 
question related to this email message is in the final paragraph.

We don't want to squash our topic branches before pushing them to 
Gerrit.  That means we end up with a range of 'n' number of commits in 
the Gerrit review screen.  Gerrit understands that commit 'n' is 
dependent on 'n-1' and so on, but unfortunately, it doesn't show them in 
a tree/group on the main page.  That's a minor gripe, but here is the 
major issue.

When I review Change 1, I can press a submit button, and Change 1 goes 
live right then.  Unfortunately, changes 2 through n were left behind.

If I review Change 1 through n and then press the Submit button on 
Change n and then on Change n-1 and then on Change n-2, Gerrit does the 
'right' thing (for us) and makes live the entire dependency chain at the 
same time.  Of course, I would prefer to just have a group Submit 
button, but that's another story.

This has come up on the mailing list a few times, and I even think there 
is an issue tracker item for it.

Let's ignore the review+submit portion of Gerrit now.  Can Gerrit be 
coaxed to take a refs/for/master and directly apply it to the master 
branch WITHOUT the review cycle?  If so, then I'm wasting my time trying 
to right a script.

Josh
