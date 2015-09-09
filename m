From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 4/5] git-p4: add support for large file systems
Date: Wed, 9 Sep 2015 22:09:52 +0200
Message-ID: <353BE0F5-8262-4094-95E6-982C29570F6B@gmail.com>
References: <1441799950-54633-1-git-send-email-larsxschneider@gmail.com> <1441799950-54633-5-git-send-email-larsxschneider@gmail.com> <xmqq37yn7bni.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 22:10:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZlgy-0004yQ-TG
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 22:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772AbbIIUJ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Sep 2015 16:09:59 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34887 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbbIIUJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Sep 2015 16:09:57 -0400
Received: by wicge5 with SMTP id ge5so168680568wic.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 13:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1xlbmsX4kIEPFSDb3noWGpRwiPbqotj17iRVfYBjUMA=;
        b=cNDLZdnJ0DCIkgjc1YzfcYKVwSMMS80AmeXLkRtql1/AAenxDAwB1xaZ+GJ6xPZffy
         ZXxz4snJzNapKUDZZbZN1geXaQqs79EyAzI42BFVRhb8p0KTEfGMBINHy5TumWjcG+hh
         CyuATWv7YU0Y2uFk9bKUmb6cv6oxzd+1wCyl9oLzsGZtokZOBxwIY099+NFtlmh7O0dG
         spnfAWxFViCDdwl0bpKnk9lezC330yW8Phg71435Zd3GYIJ0eSfM4ZcQdgXVYz8Ti8ZS
         4rS84UB9ACrwRzrSlpEYEIxWaIyghpABGd4EGHYEGwZM2NXy8TkIWkofk7abHl4MXqSd
         Q6HQ==
X-Received: by 10.194.83.70 with SMTP id o6mr22491924wjy.44.1441829395932;
        Wed, 09 Sep 2015 13:09:55 -0700 (PDT)
Received: from slxbook3.fritz.box (dslb-188-106-108-157.188.106.pools.vodafone-ip.de. [188.106.108.157])
        by smtp.gmail.com with ESMTPSA id gv1sm5535853wib.15.2015.09.09.13.09.54
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Sep 2015 13:09:54 -0700 (PDT)
In-Reply-To: <xmqq37yn7bni.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277563>


On 09 Sep 2015, at 19:20, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
>=20
>> @@ -2226,17 +2355,16 @@ class P4Sync(Command, P4UserMap):
>>             text =3D regexp.sub(r'$\1$', text)
>>             contents =3D [ text ]
>>=20
>> -        self.gitStream.write("M %s inline %s\n" % (git_mode, relPat=
h))
>> +        if relPath =3D=3D '.gitattributes':
>> +            die('.gitattributes already exists in P4.')
>=20
> This looks like an unfortunate limitation to me.
>=20
> Is it really necessary that you need to reject unrelated attributes
> the user has (presumably for a good reason)?  It seems to me that
> you only need to _add_ entries to make file extension based decision
> to send paths selectively to LFS?
No, it is not necessary. I will remove this limitation.

>=20
> Also the exact format of these attributes entries looks like very
> closely tied to GitHub LFS and not generic (for example, there is no
> reason to expect that any large-file support would always use the
> "filter" mechanism or the gitattributes mechanism for that
> matter), =85
Agreed. Instead of just the filter name I will replace everything after=
 the pathname with a single git-p4 config value:

['*.' + f.replace(' ', '[:space:]') + ' %s\n' % largeFileSystem().attri=
butes()
    for f in sorted(gitConfigList("git-p4.largeFileExtensions"))
] +
['/' + f.replace(' ', '[:space:]') + ' %s\n' % largeFileSystem().attrib=
utes()
    for f in sorted(self.largeFiles) if not self.hasLargeFileExtension(=
f)
]

This, of course, would only work for gitattributes based solutions.=20

>=20
> +    def writeGitAttributesToStream(self):
> +        self.writeToGitStream(
> +            '100644',
> +            '.gitattributes',
> +            [
> +                '\n',
> +                '#\n',
> +                '# %s\n' % largeFileSystem().attributeDescription(),
> +                '#\n',
> +            ] +
> +            ['*.' + f.replace(' ', '[:space:]') + ' filter=3D%s -tex=
t\n'
> +                % largeFileSystem().attributeFilter()
> +                for f in sorted(gitConfigList("git-p4.largeFileExten=
sions"))
> +            ] +
> +            ['/' + f.replace(' ', '[:space:]') + ' filter=3D%s -text=
\n'
> +                % largeFileSystem().attributeFilter()
> +                for f in sorted(self.largeFiles) if not self.hasLarg=
eFileExtension(f)
> +            ]
> +        )
> +
>=20
> ... so while I can see the code like the above needs to exist
> somewhere in "git p4" to support GitHub LFS, I am not sure if it
> belongs to the generic part of the code.  For the same reason, I do
> not know if these replacements with largeFileSystem().getters() are
> really adding much value.
I have the impression you would prefer to move all the attributes code =
from the generic code to the GitLFS code? I will explore that solution =
and see if I can come up with a nice generic interface.
=20
>=20
> How is collaboration between those who talk to the same p4 depot
> backed by GitHub LFS expected to work?  You use config to set size
> limits and list of file extensions in your repository, and grab new
> changes from p4 and turn them into Git commits (with pointers to LFS
> and the .gitattributes file that records your choice of the config).
> I as a new member to the same project come, clone the resulting Git
> repository from you and then what do I do before talking to the same
> p4 depot to further update the Git history?  Are the values recorded
> in .gitattributes (which essentially were derived from your
> configuration) somehow reflected back automatically to my config so
> that our world view would become consistent?  Perhaps you added
> 'iso' to largeFileExtensions before I cloned from you, and that
> would be present in the copy of .gitattributes I obtained from you.
> I may be trying to add a new ".iso" file, and I presume that an
> existing .gitattributes entry you created based on the file
> extension automatically covers it from the LFS side, but does my
> "git p4 submit" also know what to do, or would it be broken until I
> add a set of configrations that matches yours?
Well, you have a very good point here. From my point of view you can us=
e git-p4 in two ways:

_Way 1_: Your project is stored in Perforce and it will stay in Perforc=
e. You use git-p4 on a regular basis to interact with the Perforce repo=
sitory.
_Way 2_: Your project is stored in Perforce and you want to migrate it =
to Git. You use git-p4 once to perform the migration. Afterwards you ne=
ver touch git-p4 or Perforce again.

My large file system feature is intended to be used only for _Way 2_ fo=
r exactly the reasons you mentioned. Would it still be OK to add this f=
eature to git-p4? Maybe with a appropriate warning in the docs?

Thanks,
Lars

 