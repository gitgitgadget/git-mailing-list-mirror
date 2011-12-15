From: Hao Wang <billhao@gmail.com>
Subject: Re: process committed files in post-receive hook
Date: Wed, 14 Dec 2011 18:02:11 -0800
Message-ID: <4EE95523.9030702@gmail.com>
References: <loom.20111210T111457-837@post.gmane.org> <4EE94783.1010805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 03:02:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb0eK-0002Aa-J6
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 03:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758541Ab1LOCCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 21:02:16 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53857 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755804Ab1LOCCP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 21:02:15 -0500
Received: by iaeh11 with SMTP id h11so2027574iae.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 18:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=B1Nsp9xCpnFsybGve2i50Yz8I0cN8KbmLbPz1WtWlO4=;
        b=ItHJMPPox2WpT3rOkjp/bY8HIJbBWvA61slkstPljp1ldF1ibIsor1A/Shir+9pfj0
         ykK7BNVqcvZ6lD0/k9n0CHICM2h8Y2wB2MgX21ZptLaT04Nvy3jHjMEnb+Nx+lS/JXfl
         cdaHfFHz5sk9ga+39ZmIquvNTutmvUHKwpumI=
Received: by 10.50.87.227 with SMTP id bb3mr1075665igb.29.1323914534627;
        Wed, 14 Dec 2011 18:02:14 -0800 (PST)
Received: from toben-mintzs-mac-pro.local (truffle.usc.edu. [128.125.14.197])
        by mx.google.com with ESMTPS id z22sm15131658ibg.5.2011.12.14.18.02.12
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 18:02:13 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.5; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EE94783.1010805@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187183>

Thank you all for providing the options. Just so you know I finally went 
with Alexey's suggestion. I used 'git show' to get both a list of files 
in a directory and the content of each file. It works great on a bare 
repository so there is no need to check out a copy on the server.

Below is the python code in my post-receive hook for this task, where 
rev is something like 'HEAD:directory_name' for the first function and 
'HEAD:directory/filename' for the second function.

# get a list of rule files using git show
def getRuleFileList(rev):
     # run git show
     p = subprocess.Popen(['git', 'show', rev], stdout=subprocess.PIPE)
     p.wait()
     if p.returncode != 0: return None # error

     # parse output
     i = 0
     filelist = []
     for line in p.stdout.readlines():
         filelist.append(line)
     p.stdout.close()
     return filelist

# read the content of a file
def readfile(rev):
     # run git show
     p = subprocess.Popen(['git', 'show', rev], stdout=subprocess.PIPE)
     p.wait()
     if p.returncode != 0: return None # error
     return p.stdout.read()

Hao

On 12/14/11 5:04 PM, Neal Kreitzinger wrote:
> On 12/10/2011 4:29 AM, Hao wrote:
>> Hi guys,
>>
>> I am writing a post-receive hook in Python that examines the content
>> of some files (the HEAD rev). Because the repo is a bare one on the
>> server. My current approach is to check out a working copy on the
>> server and run 'git pull' in post- receive to get the most up-to-date
>> version, and then process files in the working copy.
>>
>> I have two questions. First, is there a way that I can access file
>> content in a bare repo without checking out a working copy? If this
>> is not possible, my approach would be reasonable. However, when 'git
>> pull' was called in the python script post-receive when a commit
>> occurs, it gives an error.
>>
>> remote: fatal: Not a git repository: '.'
>>
>> The call in python is
>>
>> subprocess.Popen(["git", "pull"],
>> cwd="/Users/git/ts.git.workingcopy")
>>
>> I read from a post (http://stackoverflow.com/questions/4043609/) that
>> GIT_DIR is causing this error. Is it safe to unset GIT_DIR in
>> post-receive?
>>
> The specific processing you intend to perform on the files would
> determine which of the access techniques is appropriate for you.
> Generally speaking, I think a checkout in a non-bare repo makes sense.
> You could limit it to a shallow clone (see git-clone manpage) to save
> space.
>
> Another way to get the files is git-archive (creates tar file), that you
> could extract to a dir for processing.
>
> In both cases, you need to consider the default permissions in play with
> git-checkout and git-archive if permissions are important in your
> processing.
>
> v/r,
> neal
