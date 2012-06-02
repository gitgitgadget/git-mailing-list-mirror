From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv4] Read (but not write) from XDG configuration, XDG attributes and XDG ignore files
Date: Sat, 02 Jun 2012 13:20:40 +0200
Message-ID: <vpq7gvq9czb.fsf@bauges.imag.fr>
References: <1338475242-21770-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	<1338585788-9764-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Lucien KONG <Lucien.Kong@ensimag.imag.fr>,
	Valentin DUPERRAY <Valentin.Duperray@ensimag.imag.fr>,
	Thomas NGUY <Thomas.Nguy@ensimag.imag.fr>,
	Franck JONAS <Franck.Jonas@ensimag.imag.fr>
To: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 02 13:20:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SamO5-0000Y3-0G
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 13:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966568Ab2FBLUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 07:20:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44967 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965619Ab2FBLUq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 07:20:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q52BCFSV002531
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 2 Jun 2012 13:12:15 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SamNt-0005Wj-CO; Sat, 02 Jun 2012 13:20:41 +0200
In-Reply-To: <1338585788-9764-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	(Huynh Khoi Nguyen NGUYEN's message of "Fri, 1 Jun 2012 23:23:08
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 02 Jun 2012 13:12:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q52BCFSV002531
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339240337.49115@1/A1UcOyCRpoxLJPoQ8r/A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199041>

Huynh Khoi Nguyen NGUYEN <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
writes:

> Git will not be able to write in this new configuration file.

The use of the future is ambiguous, and since another patch will allow
writing, I'd rather rephrase it as e.g.

Git currently does not write to this new configuration file.

> If core.excludesfile is not define, Git will read the global exclude

s/define/defined/

> files in $XDG_CONFIG_HOME/git/ignore. Same goes for
> core.attributesfile in $XDG_CONFIG_HOME/git/attributes. If
> $XDG_CONFIG_HOME is either not set or empty, $HOME/.config will be
> used.

I'd prefer having two separate patches for the config file and for the
two others. If ignore and attributes are simple enough, they may go to
the same patch, but ideally, there would be two separate patches again.

> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt

No doc for core.excludesfile and core.attributesfile change :-(.

> --- a/attr.c
> +++ b/attr.c
> @@ -497,6 +497,9 @@ static int git_attr_system(void)
>  static void bootstrap_attr_stack(void)
>  {
>  	struct attr_stack *elem;
> +	char *xdg_attributes_file;
> +
> +	home_config_paths(NULL, &xdg_attributes_file, "attributes");
>  
>  	if (attr_stack)
>  		return;
> @@ -522,6 +525,13 @@ static void bootstrap_attr_stack(void)
>  			elem->prev = attr_stack;
>  			attr_stack = elem;
>  		}
> +	} else if (!access(xdg_attributes_file, R_OK)) {
> +		elem = read_attr_from_file(xdg_attributes_file, 1);
> +		if (elem) {
> +			elem->origin = NULL;
> +			elem->prev = attr_stack;
> +			attr_stack = elem;
> +		}
>  	}
>  
>  	if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {

The logic seems overly complex, and you duplicate the if() uselessly.

Why not just set the variable git_attributes_file before entering the
if? Something like this:

diff --git a/attr.c b/attr.c
index 303751f..71dc472 100644
--- a/attr.c
+++ b/attr.c
@@ -515,6 +515,9 @@ static void bootstrap_attr_stack(void)
 		}
 	}
 
+	if (!git_attributes_file)
+		git_attributes_file = "foo";
+
 	if (git_attributes_file) {
 		elem = read_attr_from_file(git_attributes_file, 1);
 		if (elem) {

(obviously replacing "foo" by the actual code involving
home_config_paths(..., "attributes")).

Doing so, you may even get rid of the "if (git_attributes_file)" on the
next line.

Then, the logic is really "core.excludesfile defaults to the XDG file",
not "if such variable is set then do that else do something else".

> --- a/dir.c
> +++ b/dir.c
> @@ -1234,13 +1234,17 @@ int remove_dir_recursively(struct strbuf *path, int flag)
>  void setup_standard_excludes(struct dir_struct *dir)
>  {
>  	const char *path;
> +	char *xdg_path;
>  
>  	dir->exclude_per_dir = ".gitignore";
>  	path = git_path("info/exclude");
> +	home_config_paths(NULL, &xdg_path, "ignore");
>  	if (!access(path, R_OK))
>  		add_excludes_from_file(dir, path);
>  	if (excludes_file && !access(excludes_file, R_OK))
>  		add_excludes_from_file(dir, excludes_file);
> +	else if (!access(xdg_path, R_OK))
> +		add_excludes_from_file(dir, xdg_path);
>  }

Same remark here. Look at the patch I sent earlier to give a default
value:

http://thread.gmane.org/gmane.comp.version-control.git/133343/focus=133415

For example, you version reads from XDG file if core.excludesfile is
set, but the file it points to doesn't exist. I don't think this is
expected.

> +	echo foo >to_be_excluded &&
> +	git add to_be_excluded &&
> +	git rm --cached to_be_excluded &&

Err, why add and remove it? You just need to create it, right?

> +	cd .. &&
> +	mkdir -p .config/git/ &&

I don't like these relative references to $HOME. If you mean $HOME, why
not say

mkdir -p $HOME/.config/git/
echo "f attr_f" >$HOME/.config/git/

?

(you don't even need to "cd")

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
