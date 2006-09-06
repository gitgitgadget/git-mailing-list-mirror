From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/2] Add git-archive
Date: Wed, 06 Sep 2006 22:14:47 +0200
Message-ID: <44FF2C37.2010400@lsrfire.ath.cx>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com> <7vfyf6ce29.fsf@assigned-by-dhcp.cox.net> <44FED12E.7010409@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 22:15:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL3nZ-0004bH-Od
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 22:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbWIFUO6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 6 Sep 2006 16:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbWIFUO6
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 16:14:58 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:58546
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751533AbWIFUO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 16:14:57 -0400
Received: from [10.0.1.3] (p508E760A.dip.t-dialin.net [80.142.118.10])
	by neapel230.server4you.de (Postfix) with ESMTP id 1A6C81400D;
	Wed,  6 Sep 2006 22:14:56 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <44FED12E.7010409@innova-card.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26556>

=46ranck Bui-Huu schrieb:
> Junio C Hamano wrote:
>> "Franck Bui-Huu" <vagabon.xyz@gmail.com> writes:
>>
>>> git-archive is a command to make TAR and ZIP archives of a git tree=
=2E
>>> It helps prevent a proliferation of git-{format}-tree commands.
>> Thanks.  I like the overall structure, at least mostly.
>> Also dropping -tree suffix from the command name is nice, short
>> and sweet.
>>
>=20
> great !
>=20
>> Obviously I cannot apply this patch because it is totally
>> whitespace damaged, but here are some comments.
>=20
> (sigh), sorry for that.
>=20
>>> diff --git a/archive.h b/archive.h
>>> new file mode 100644
>>> index 0000000..6c69953
>>> --- /dev/null
>>> +++ b/archive.h
>>> @@ -0,0 +1,43 @@
>>> +#ifndef ARCHIVE_H
>>> +#define ARCHIVE_H
>>> +
>>> +typedef int (*write_archive_fn_t)(struct tree *tree,
>>> +				  const unsigned char *commit_sha1,
>>> +				  const char *prefix,
>>> +				  time_t time,
>>> +				  const char **pathspec);
>> The type of the first argument might have to be different,
>> depending on performance analysis by Rene on struct tree vs
>> struct tree_desc.
>>
>=20
> OK. We'll wait for Rene.

The performance difference I noticed was caused by a memleak; the speed
advantage of a struct tree_desc based traverser is significant if you
look only at the traversers' performance, but it is lost in the noise
of the "real" work that the payload function is doing (see my other
mail).

>>> +static int run_remote_archiver(struct archiver_struct *ar, int arg=
c,
>>> +			       const char **argv)
>>> +{
>>> +	char *url, buf[1024];
>>> +	pid_t pid;
>>> +	int fd[2];
>>> +	int len, rv;
>>> +
>>> +	sprintf(buf, "git-upload-%s", ar->name);
>> Are you calling git-upload-{tar,zip,rar,...} here?
>>
>=20
> yes. Actually git-upload-{tar,zip,...} commands are going to be
> removed, but git-daemon know them as a daemon service. It will
> map these services to the generic "git-upload-archive" command.
> One benefit is that we could still disable TAR format and enable
> TGZ one. Please take a look to the second patch that adds
> git-upload-archive command.

I don't think git-daemon should need to care about specific
archivers.  Policy decisions, like disallowing certain archive types
or compression levels, should be made in git-upload-archive.  This
way all code regarding archive uploading is found in one place:
git-upload-archive.  We can keep git-upload-tar as a legacy
interface, but please use only git-upload-archive for the new stuff
(and not git-upload-zip etc.).

>>> +int parse_treeish_arg(const char **argv, struct tree **tree,
>>> +		      const unsigned char **commit_sha1,
>>> +		      time_t *archive_time, const char *prefix,
>>> +		      const char **reason)
>>> +{
>>> ...
>>> +	if (prefix) {
>>> +		unsigned char tree_sha1[20];
>>> +		unsigned int mode;
>>> +		int err;
>>> +
>>> +		err =3D get_tree_entry((*tree)->object.sha1, prefix,
>>> +				     tree_sha1, &mode);
>>> +		if (err || !S_ISDIR(mode)) {
>>> +			*reason =3D "current working directory is untracked";
>>> +			goto out;
>>> +		}
>>> +		free(*tree);
>>> +		*tree =3D parse_tree_indirect(tree_sha1);
>>> +	}
>> I like the simplicity of just optionally sending one subtree (or
>> the whole thing), but I think this part would be made more
>> efficient if we go with "struct tree_desc" based interface.
>>
>> Also I wonder how this interacts with the pathspec you take from
>> the command line.  Personally I think this single subtree
>> support is good enough and limiting with pathspec is not needed.

[Note: There's potential for confusion here because we have two
types of prefixes.  One is the present working directory inside the
git archive, the other is the one specified with --prefix=3D.  Here
we have the working directory kind of prefix.]

IMHO should work like in the following example, and the code above
cuts off the Documentation part:

   $ cd Documentation
   $ git-archive --format=3Dtar --prefix=3Dv1.0/ HEAD howto | tar tf -
   v1.0/howto/
   v1.0/howto/isolate-bugs-with-bisect.txt
   ...

I agree that simple subtree matching would be enough, at least for
now.

Ren=E9
