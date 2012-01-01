From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: How to deal with historic tar-balls
Date: Sun, 01 Jan 2012 20:04:29 +0100
Message-ID: <4F00AE3D.9050102@dirk.my1.cc>
References: <4EFF5CDA.5050809@gmail.com> <4EFFA868.50605@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: nn6eumtr <nn6eumtr@gmail.com>, git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Sun Jan 01 20:06:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhQk7-0002GB-HB
	for gcvg-git-2@lo.gmane.org; Sun, 01 Jan 2012 20:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab2AATGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jan 2012 14:06:47 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.35]:52020 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab2AATGq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jan 2012 14:06:46 -0500
Received: from [217.87.101.90] (helo=[192.168.2.100])
	by smtprelay01.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1RhQhq-0006Y1-Ju; Sun, 01 Jan 2012 20:04:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EFFA868.50605@dbservice.com>
X-Df-Sender: NzU3NjQ2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187828>

Am 01.01.2012 01:27 schrieb Tomas Carnecky:
> On 12/31/11 8:04 PM, nn6eumtr wrote:
>> I have a number of older projects that I want to bring into a git
>> repository. They predate a lot of the popular scm systems, so they are
>> primarily a collection of tarballs today.
>>
>> I'm fairly new to git so I have a couple questions related to this:
>>
>> - What is the best approach for bringing them in? Do I just create a
>> repository, then unpack the files, commit them, clean out the
>> directory unpack the next tarball, and repeat until everything is loaded?
>>
>> - Do I need to pay special attention to files that are renamed/removed
>> from version to version?
>>
>> - If the timestamps change on a file but the actual content does not,
>> will git treat it as a non-change once it realizes the content hasn't
>> changed?
>>
>> - Last, if after loading the repository I find another version of the
>> files that predates those I've loaded, or are intermediate between two
>> commits I've already loaded, is there a way to go say that commit B is
>> actually the ancestor of commit C? (i.e. a->c becomes a->b->c if you
>> were to visualize the commit timeline or do diffs) Or do I just reload
>> the tarballs in order to achieve this?
> 
> There is a script which will import sources from multiple tarballs,
> creating a commit with the contents of each tarball. It's in the git
> repository under contrib/fast-import/import-tars.perl.
> 
> tom

@tom: True. I didn't know about that script, but it should work.

@nn6eumtr: Basically your workflow is perfect. But let me give you some
explanation:

git init
foreach archive in *.tar; do
    tar xf $archive
    git add --all .
    git commit -m "Added $archive"
    # now remove everything except for the .git directory
    # with regular shell commands (rm -rf *). Also remove
    # any dot-files (and the tarball itself, if it's in the
    # current directory).
done

Notice the '--all' switch to 'git add': Normally, 'git add .' adds all
files that match the given pattern '.', i.e. all files in the current
directory (and below, it's recursive). The '--all' switch together with
the pattern '.' adds or updates all files already known to git *AND*
adds the files not yet known *AND* removes the files that are no longer
in the working tree. That's exactly what you want.

Consider archive1.tar with files A, B, C:

  git add --all . # will add A, B, and C

Now remove A, B, C, and unpack archive2.tar. Assume it has files B, C,
D. A was deleted, B was changed, C is unchanged, D is new.

  git add --all . # will remove A, add B, leave C, add D.

git will notice that C hasn't changed its content (timestamp doesn't
matter).

Without the '--all' switch, git would simply add B and D.

There is no problem re-arranging the history after your import (see "git
rebase --help", especially the --interactive section), but then you
probably will have conflicts and have to resolve them. I'd suggest to
re-start the import instead.

Please note that "for archive in *.tar" will pick the tarballs in
lexicographical order. That might not be your intention.

HTH,
    Dirk
