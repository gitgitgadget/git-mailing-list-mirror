From: nguyenhu@minatec.inpg.fr
Subject: Re: [PATCHv4] Read (but not write) from XDG configuration, XDG
 attributes and XDG ignore files
Date: Sat, 02 Jun 2012 17:52:09 +0200
Message-ID: <20120602175209.Horde.QpN5M3wdC4BPyjaps7w1bMA@webmail.minatec.grenoble-inp.fr>
References: <1338475242-21770-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338585788-9764-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <vpq7gvq9czb.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=";";
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Lucien KONG <Lucien.Kong@ensimag.imag.fr>,
	Valentin DUPERRAY <Valentin.Duperray@ensimag.imag.fr>,
	Thomas NGUY <Thomas.Nguy@ensimag.imag.fr>,
	Franck JONAS <Franck.Jonas@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jun 02 17:52:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Saqcl-00027D-UW
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 17:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377Ab2FBPwO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jun 2012 11:52:14 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:51036 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759069Ab2FBPwN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jun 2012 11:52:13 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 34CD21A0260;
	Sat,  2 Jun 2012 17:52:10 +0200 (CEST)
Received: from 183.24.91.79.rev.sfr.net (183.24.91.79.rev.sfr.net
 [79.91.24.183]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Sat, 02 Jun 2012 17:52:09 +0200
In-Reply-To: <vpq7gvq9czb.fsf@bauges.imag.fr>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199045>



Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> a =C3=A9crit=C2=A0:

> I'd prefer having two separate patches for the config file and for th=
e
> two others. If ignore and attributes are simple enough, they may go t=
o
> the same patch, but ideally, there would be two separate patches agai=
n.

We will separate this patch in three different patches.

> No doc for core.excludesfile and core.attributesfile change :-(.

It will be done for the next patch ;)

>> --- a/attr.c
>> +++ b/attr.c
>> @@ -497,6 +497,9 @@ static int git_attr_system(void)
>>  static void bootstrap_attr_stack(void)
>>  {
>>  	struct attr_stack *elem;
>> +	char *xdg_attributes_file;
>> +
>> +	home_config_paths(NULL, &xdg_attributes_file, "attributes");
>>
>>  	if (attr_stack)
>>  		return;
>> @@ -522,6 +525,13 @@ static void bootstrap_attr_stack(void)
>>  			elem->prev =3D attr_stack;
>>  			attr_stack =3D elem;
>>  		}
>> +	} else if (!access(xdg_attributes_file, R_OK)) {
>> +		elem =3D read_attr_from_file(xdg_attributes_file, 1);
>> +		if (elem) {
>> +			elem->origin =3D NULL;
>> +			elem->prev =3D attr_stack;
>> +			attr_stack =3D elem;
>> +		}
>>  	}
>>
>>  	if (!is_bare_repository() || direction =3D=3D GIT_ATTR_INDEX) {
>
> The logic seems overly complex, and you duplicate the if() uselessly.
>
> Why not just set the variable git_attributes_file before entering the
> if? Something like this:
>
> diff --git a/attr.c b/attr.c
> index 303751f..71dc472 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -515,6 +515,9 @@ static void bootstrap_attr_stack(void)
>  		}
>  	}
>
> +	if (!git_attributes_file)
> +		git_attributes_file =3D "foo";
> +
>  	if (git_attributes_file) {
>  		elem =3D read_attr_from_file(git_attributes_file, 1);
>  		if (elem) {
>
> (obviously replacing "foo" by the actual code involving
> home_config_paths(..., "attributes")).
>
> Doing so, you may even get rid of the "if (git_attributes_file)" on t=
he
> next line.

We first thought to use an "else if" in order not to pointlessly check =
the
existence of the xdg_attributes_file (or double checking git_attributes=
_file)
if git_attributes_file exists.
BTW after checking the code more closely, we do not need to verify the =
=20
existence of the xdg_attributes_file so it is indeed more clean to use =
=20
your version, Thank.

>> --- a/dir.c
>> +++ b/dir.c
>> @@ -1234,13 +1234,17 @@ int remove_dir_recursively(struct strbuf =20
>> *path, int flag)
>>  void setup_standard_excludes(struct dir_struct *dir)
>>  {
>>  	const char *path;
>> +	char *xdg_path;
>>
>>  	dir->exclude_per_dir =3D ".gitignore";
>>  	path =3D git_path("info/exclude");
>> +	home_config_paths(NULL, &xdg_path, "ignore");
>>  	if (!access(path, R_OK))
>>  		add_excludes_from_file(dir, path);
>>  	if (excludes_file && !access(excludes_file, R_OK))
>>  		add_excludes_from_file(dir, excludes_file);
>> +	else if (!access(xdg_path, R_OK))
>> +		add_excludes_from_file(dir, xdg_path);
>>  }
> Same remark here. Look at the patch I sent earlier to give a default
> value:
>
> http://thread.gmane.org/gmane.comp.version-control.git/133343/focus=3D=
133415
>
> For example, you version reads from XDG file if core.excludesfile is
> set, but the file it points to doesn't exist. I don't think this is
> expected.

Actually, it's the opposite. Our version only read from XDG file if =20
core.excludesfile is not set.
After checking your patch, it may be more logical to inialize the defau=
lt
value of excludes_file to the xdg_path as done for the attributes file.

>> +	echo foo >to_be_excluded &&
>> +	git add to_be_excluded &&
>> +	git rm --cached to_be_excluded &&
>
> Err, why add and remove it? You just need to create it, right?

It was to check if to_be_excluded is indeed not ignored at the beginnin=
g
of the test before ignoring it but that's seem a bit over-testing, I'll
remove it.

>> +	cd .. &&
>> +	mkdir -p .config/git/ &&
>
> I don't like these relative references to $HOME. If you mean $HOME, w=
hy
> not say
>
> mkdir -p $HOME/.config/git/
> echo "f attr_f" >$HOME/.config/git/
>
> ?

It will be fixed but BTW where the tests are executed,
$HOME has a weird behaviour:

echo $HOME and echo "$HOME"
      both returns /.../t/trash directory.t1306-read-xdg-config-file
but   echo foo >$HOME   writes in ../t/trash
while echo foo >"$HOME" writes in t/trash directory.t1306-read-xdg-conf=
ig-file
so "$HOME" is needed for the tests to work.
