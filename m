From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: [PATCH/RFC v3 16/16] Add a test script for remote-svn.
Date: Wed, 15 Aug 2012 13:46:26 +0200
Message-ID: <11611888.mV2cRFPk88@flomedio>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1344971598-8213-16-git-send-email-florian.achleitner.2.6.31@gmail.com> <1344971598-8213-17-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 13:46:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1c3e-0007ld-Kg
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 13:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705Ab2HOLqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 07:46:36 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:5301 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab2HOLqf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 07:46:35 -0400
Received: from flomedio.localnet (089144206028.atnat0015.highway.a1.net [89.144.206.28])
	(authenticated bits=0)
	by mailrelay2.tugraz.at (8.14.4/8.14.4) with ESMTP id q7FBkSk0019220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 15 Aug 2012 13:46:28 +0200 (CEST)
User-Agent: KMail/4.8.4 (Linux/3.0.0-24-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <1344971598-8213-17-git-send-email-florian.achleitner.2.6.31@gmail.com>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.3
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203468>

Forget this patch! It contains some unwanted content. Something with rebasing 
went wrong..

On Tuesday 14 August 2012 21:13:18 Florian Achleitner wrote:
> Use svnrdump_sim.py to emulate svnrdump without an svn server.
> Tests fetching, incremental fetching, fetching from file://,
> and the regeneration of fast-import's marks file.
> 
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> ---
>  t/t9020-remote-svn.sh |   69
> +++++++++++++++++++++++++++++++++++++++++++++++++ transport-helper.c    |  
> 15 ++++++-----
>  2 files changed, 77 insertions(+), 7 deletions(-)
>  create mode 100755 t/t9020-remote-svn.sh
> 
> diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
> new file mode 100755
> index 0000000..a0c6a21
> --- /dev/null
> +++ b/t/t9020-remote-svn.sh
> @@ -0,0 +1,69 @@
> +#!/bin/sh
> +
> +test_description='tests remote-svn'
> +
> +. ./test-lib.sh
> +
> +# We override svnrdump by placing a symlink to the svnrdump-emulator in .
> +export PATH="$HOME:$PATH"
> +ln -sf $GIT_BUILD_DIR/contrib/svn-fe/svnrdump_sim.py "$HOME/svnrdump"
> +
> +init_git () {
> +	rm -fr .git &&
> +	git init &&
> +	#git remote add svnsim svn::sim:///$TEST_DIRECTORY/t9020/example.svnrdump
> +	# let's reuse an exisiting dump file!?
> +	git remote add svnsim svn::sim:///$TEST_DIRECTORY/t9154/svn.dump
> +	git remote add svnfile svn::file:///$TEST_DIRECTORY/t9154/svn.dump
> +}
> +
> +test_debug '
> +	git --version
> +	which git
> +	which svnrdump
> +'
> +
> +test_expect_success 'simple fetch' '
> +	init_git &&
> +	git fetch svnsim &&
> +	test_cmp .git/refs/svn/svnsim/master .git/refs/remotes/svnsim/master  &&
> +	cp .git/refs/remotes/svnsim/master master.good
> +'
> +
> +test_debug '
> +	cat .git/refs/svn/svnsim/master
> +	cat .git/refs/remotes/svnsim/master
> +'
> +
> +test_expect_success 'repeated fetch, nothing shall change' '
> +	git fetch svnsim &&
> +	test_cmp master.good .git/refs/remotes/svnsim/master
> +'
> +
> +test_expect_success 'fetch from a file:// url gives the same result' '
> +	git fetch svnfile
> +'
> +
> +test_expect_failure 'the sha1 differ because the git-svn-id line in the
> commit msg contains the url' ' +	test_cmp .git/refs/remotes/svnfile/master
> .git/refs/remotes/svnsim/master +'
> +
> +test_expect_success 'mark-file regeneration' '
> +	mv .git/info/fast-import/marks/svnsim
> .git/info/fast-import/marks/svnsim.old && +	git fetch svnsim &&
> +	test_cmp .git/info/fast-import/marks/svnsim.old
> .git/info/fast-import/marks/svnsim +'
> +
> +test_expect_success 'incremental imports must lead to the same head' '
> +	export SVNRMAX=3 &&
> +	init_git &&
> +	git fetch svnsim &&
> +	test_cmp .git/refs/svn/svnsim/master .git/refs/remotes/svnsim/master  &&
> +	unset SVNRMAX &&
> +	git fetch svnsim &&
> +	test_cmp master.good .git/refs/remotes/svnsim/master
> +'
> +
> +test_debug 'git branch -a'
> +
> +test_done
> diff --git a/transport-helper.c b/transport-helper.c
> index 47db055..a363f2c 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -17,6 +17,7 @@ static int debug;
>  struct helper_data {
>  	const char *name;
>  	struct child_process *helper;
> +	struct argv_array argv;
>  	FILE *out;
>  	unsigned fetch : 1,
>  		import : 1,
> @@ -103,7 +104,6 @@ static void do_take_over(struct transport *transport)
>  static struct child_process *get_helper(struct transport *transport)
>  {
>  	struct helper_data *data = transport->data;
> -	struct argv_array argv = ARGV_ARRAY_INIT;
>  	struct strbuf buf = STRBUF_INIT;
>  	struct child_process *helper;
>  	const char **refspecs = NULL;
> @@ -125,10 +125,11 @@ static struct child_process *get_helper(struct
> transport *transport) helper->in = -1;
>  	helper->out = -1;
>  	helper->err = 0;
> -	argv_array_pushf(&argv, "git-remote-%s", data->name);
> -	argv_array_push(&argv, transport->remote->name);
> -	argv_array_push(&argv, remove_ext_force(transport->url));
> -	helper->argv = argv.argv;
> +	argv_array_init(&data->argv);
> +	argv_array_pushf(&data->argv, "git-remote-%s", data->name);
> +	argv_array_push(&data->argv, transport->remote->name);
> +	argv_array_push(&data->argv, remove_ext_force(transport->url));
> +	helper->argv = data->argv.argv;
>  	helper->git_cmd = 0;
>  	helper->silent_exec_failure = 1;
> 
> @@ -143,8 +144,6 @@ static struct child_process *get_helper(struct transport
> *transport)
> 
>  	data->helper = helper;
>  	data->no_disconnect_req = 0;
> -	free((void*) helper_env[1]);
> -	argv_array_clear(&argv);
> 
>  	/*
>  	 * Open the output as FILE* so strbuf_getline() can be used.
> @@ -247,6 +246,8 @@ static int disconnect_helper(struct transport
> *transport) close(data->helper->out);
>  		fclose(data->out);
>  		res = finish_command(data->helper);
> +		free((void*) data->helper->env[1]);
> +		argv_array_clear(&data->argv);
>  		free(data->helper);
>  		data->helper = NULL;
>  	}
