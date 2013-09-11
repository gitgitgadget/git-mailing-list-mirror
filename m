From: Lee Carver <Lee.Carver@servicenow.com>
Subject: Re: [PATCH-v3] Allow git-filter-branch to process large
 repositories with lots of branches.
Date: Wed, 11 Sep 2013 00:21:15 +0000
Message-ID: <CE550501.19691%lee.carver@corp.service-now.com>
References: <xmqqli34uuvy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Lee Carver <leeca@pnambic.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 02:21:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJYBn-00049M-8H
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 02:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533Ab3IKAVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 20:21:32 -0400
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:39391 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751044Ab3IKAVb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 20:21:31 -0400
Received: from smtprelay.corp.service-now.com ([4.71.115.101]) (using TLSv1) by na3sys009aob105.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUi+3h/rM4VM3OksxSdzWN4cuGyY0kjWK@postini.com; Tue, 10 Sep 2013 17:21:31 PDT
Received: from SJC4EXDAG01-01.corp.service-now.com
 ([fe80::9d9c:f9e1:ea7b:618c]) by SJC4EXHTCAS01.corp.service-now.com ([::1])
 with mapi id 14.02.0347.000; Tue, 10 Sep 2013 17:21:16 -0700
Thread-Topic: [PATCH-v3] Allow git-filter-branch to process large
 repositories with lots of branches.
Thread-Index: AQHOrnxFXsM3E9YpfkOwgb6VhXl7tJm/rK0A
In-Reply-To: <xmqqli34uuvy.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.15.40.100]
Content-ID: <C48EC824C73AEF42B75A4503C28D584F@corp.service-now.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234515>



On 9/10/13 4:20 PM, "Junio C Hamano" <gitster@pobox.com> wrote:

>Lee Carver <Lee.Carver@servicenow.com> writes:
>
>> As noted in several forums, a recommended way to move trees between
>> repositories
>> is to use git-filter-branch to revise the history for a single tree:
>>
>> 
>>http://gbayer.com/development/moving-files-from-one-git-repository-to-ano
>>th
>> er-preserving-history/
>> 
>>http://stackoverflow.com/questions/1365541/how-to-move-files-from-one-git
>>-r
>> epo-to-another-not-a-clone-preserving-history
>>
>> However, this can lead to argument list too long errors when the
>>original
>> repository has many retained branches (>6k)
>>
>> /usr/local/git/libexec/git-core/git-filter-branch: line 270:
>> /usr/local/git/libexec/git-core/git: Argument list too long
>> Could not get the commits
>>
>> Piping the saved output from git rev-parse into git rev-list avoids this
>> problem, since the rev-parse output is not processed as a command line
>> argument.
>> ---
>>  git-filter-branch.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
>> index ac2a005..2091885 100755
>> --- a/git-filter-branch.shgit
>> +++ b/git-filter-branch.sh
>> @@ -255,7 +255,7 @@ else
>>  	remap_to_ancestor=t
>>  fi
>>  
>> -rev_args=$(git rev-parse --revs-only "$@")
>> +git rev-parse --revs-only "$@" > ../parse
>
>Where is this "rev-parse" command running?  Is it always safe to
>clobber the file "../parse" like this?

It is using the same ${tempdir} working directory that git rev-list uses
below for the ../revs file

It's normally .git-rewrite/t, following the normal working directory setup
near line 205.

>
>>  
>>  case "$filter_subdir" in
>>  "")
>> @@ -268,7 +268,7 @@ case "$filter_subdir" in
>>  esac
>>  
>>  git rev-list --reverse --topo-order --default HEAD \
>> -	--parents --simplify-merges $rev_args "$@" > ../revs ||
>> +	--parents --simplify-merges --stdin "$@" < ../parse > ../revs ||
>>  	die "Could not get the commits"
>>  commits=$(wc -l <../revs | tr -d " ")
