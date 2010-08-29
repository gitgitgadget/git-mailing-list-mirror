From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 10/13] transport-helper: implement marks location as
 capability
Date: Sun, 29 Aug 2010 15:52:48 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1008291536030.14365@iabervon.org>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com> <1283053540-27042-11-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 21:53:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpnwB-0007Sc-Dv
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 21:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960Ab0H2TxC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 15:53:02 -0400
Received: from iabervon.org ([66.92.72.58]:59868 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753685Ab0H2TxA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 15:53:00 -0400
Received: (qmail 5095 invoked by uid 1000); 29 Aug 2010 19:52:48 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Aug 2010 19:52:48 -0000
In-Reply-To: <1283053540-27042-11-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154708>

On Sat, 28 Aug 2010, Sverre Rabbelier wrote:

> While this requires the helper to flush stdout after listing 'gitdir'
> as capability, and read a command (the 'gitdir' response from the
> remote helper infrastructure) right after that, this is more elegant
> and does not require an ad-hoc exchange of values.
> 
> CC: Daniel Barkalow <barkalow@iabervon.org>
> ---
> 
>   Daniel made some fuss about the ad-hoc exchange when I first sent
>   the 'export command' series for review, and it's been nagging me.
> 
>   As you can see in the remote-testgit implementation, it's a bit
>   icky on the helper side (you have to flush sdout and read another
>   command in the middle of responding to 'capabilities'), but I think
>   it's better than the alternative.

I think I was annoyed by it being ad-hoc, rather than having the exchange 
of values. I think if you need to get more information to the helper, you 
should have a generic mechanism for that, rather than anything that cares 
about the particular information involved.

I'm a bit unclear on what change you're making here; it looks like the 
helper side is reading another line, but that transport-helper isn't 
writing anything new, and you don't have any changes to the documentation 
here. Did this change get mixed into a different patch or something?

>  git-remote-testgit.py |   29 ++++++++++++++++-------------
>  transport-helper.c    |   47 ++++++++++++++++++-----------------------------
>  2 files changed, 34 insertions(+), 42 deletions(-)
> 
> diff --git a/git-remote-testgit.py b/git-remote-testgit.py
> index 50341ce..e2b213d 100644
> --- a/git-remote-testgit.py
> +++ b/git-remote-testgit.py
> @@ -71,8 +71,24 @@ def do_capabilities(repo, args):
>      print "import"
>      print "export"
>      print "gitdir"
> +
> +    sys.stdout.flush()
> +    if not read_one_line(repo):
> +        die("Expected gitdir, got empty line")
> +
>      print "refspec refs/heads/*:%s*" % repo.prefix
>  
> +    dirname = repo.get_base_path(repo.gitdir)
> +
> +    if not os.path.exists(dirname):
> +        os.makedirs(dirname)
> +
> +    path = os.path.join(dirname, 'testgit.marks')
> +
> +    print "*export-marks %s" % path
> +    if os.path.exists(path):
> +        print "*import-marks %s" % path
> +
>      print # end capabilities
>  
>  
> @@ -142,19 +158,6 @@ def do_export(repo, args):
>      if not repo.gitdir:
>          die("Need gitdir to export")
>  
> -    dirname = repo.get_base_path(repo.gitdir)
> -
> -    if not os.path.exists(dirname):
> -        os.makedirs(dirname)
> -
> -    path = os.path.join(dirname, 'testgit.marks')
> -    print path
> -    if os.path.exists(path):
> -        print path
> -    else:
> -        print ""
> -    sys.stdout.flush()
> -
>      update_local_repo(repo)
>      repo.importer.do_import(repo.gitdir)
>      repo.non_local.push(repo.gitdir)
> diff --git a/transport-helper.c b/transport-helper.c
> index 82bdad3..0edc1d5 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -23,6 +23,8 @@ struct helper_data
>  		push : 1,
>  		connect : 1,
>  		no_disconnect_req : 1;
> +	char *export_marks;
> +	char *import_marks;
>  	/* These go from remote name (as in "list") to private name */
>  	struct refspec *refspecs;
>  	int refspec_nr;
> @@ -179,6 +181,16 @@ static struct child_process *get_helper(struct transport *transport)
>  			strbuf_addf(&gitdir, "gitdir %s\n", get_git_dir());
>  			sendline(data, &gitdir);
>  			strbuf_release(&gitdir);
> +		} else if (!prefixcmp(capname, "export-marks ")) {
> +			struct strbuf arg = STRBUF_INIT;
> +			strbuf_addstr(&arg, "--export-marks=");
> +			strbuf_addstr(&arg, capname + strlen("export-marks "));
> +			data->export_marks = strbuf_detach(&arg, NULL);
> +		} else if (!prefixcmp(capname, "import-marks")) {
> +			struct strbuf arg = STRBUF_INIT;
> +			strbuf_addstr(&arg, "--import-marks=");
> +			strbuf_addstr(&arg, capname + strlen("import-marks "));
> +			data->import_marks = strbuf_detach(&arg, NULL);
>  		} else if (mandatory) {
>  			die("Unknown mandatory capability %s. This remote "
>  			    "helper probably needs newer version of Git.\n",
> @@ -364,10 +376,9 @@ static int get_importer(struct transport *transport, struct child_process *fasti
>  
>  static int get_exporter(struct transport *transport,
>  			struct child_process *fastexport,
> -			const char *export_marks,
> -			const char *import_marks,
>  			struct string_list *revlist_args)
>  {
> +	struct helper_data *data = transport->data;
>  	struct child_process *helper = get_helper(transport);
>  	int argc = 0, i;
>  	memset(fastexport, 0, sizeof(*fastexport));
> @@ -378,10 +389,10 @@ static int get_exporter(struct transport *transport,
>  	fastexport->argv = xcalloc(5 + revlist_args->nr, sizeof(*fastexport->argv));
>  	fastexport->argv[argc++] = "fast-export";
>  	fastexport->argv[argc++] = "--use-done-feature";
> -	if (export_marks)
> -		fastexport->argv[argc++] = export_marks;
> -	if (import_marks)
> -		fastexport->argv[argc++] = import_marks;
> +	if (data->export_marks)
> +		fastexport->argv[argc++] = data->export_marks;
> +	if (data->import_marks)
> +		fastexport->argv[argc++] = data->import_marks;
>  
>  	for (i = 0; i < revlist_args->nr; i++)
>  		fastexport->argv[argc++] = revlist_args->items[i].string;
> @@ -708,7 +719,6 @@ static int push_refs_with_export(struct transport *transport,
>  	struct ref *ref;
>  	struct child_process *helper, exporter;
>  	struct helper_data *data = transport->data;
> -	char *export_marks = NULL, *import_marks = NULL;
>  	struct string_list revlist_args = { NULL, 0, 0 };
>  	struct strbuf buf = STRBUF_INIT;
>  
> @@ -716,26 +726,6 @@ static int push_refs_with_export(struct transport *transport,
>  
>  	write_constant(helper->in, "export\n");
>  
> -	recvline(data, &buf);
> -	if (debug)
> -		fprintf(stderr, "Debug: Got export_marks '%s'\n", buf.buf);
> -	if (buf.len) {
> -		struct strbuf arg = STRBUF_INIT;
> -		strbuf_addstr(&arg, "--export-marks=");
> -		strbuf_addbuf(&arg, &buf);
> -		export_marks = strbuf_detach(&arg, NULL);
> -	}
> -
> -	recvline(data, &buf);
> -	if (debug)
> -		fprintf(stderr, "Debug: Got import_marks '%s'\n", buf.buf);
> -	if (buf.len) {
> -		struct strbuf arg = STRBUF_INIT;
> -		strbuf_addstr(&arg, "--import-marks=");
> -		strbuf_addbuf(&arg, &buf);
> -		import_marks = strbuf_detach(&arg, NULL);
> -	}
> -
>  	strbuf_reset(&buf);
>  
>  	for (ref = remote_refs; ref; ref = ref->next) {
> @@ -754,8 +744,7 @@ static int push_refs_with_export(struct transport *transport,
>  
>  	}
>  
> -	if (get_exporter(transport, &exporter,
> -			 export_marks, import_marks, &revlist_args))
> +	if (get_exporter(transport, &exporter, &revlist_args))
>  		die("Couldn't run fast-export");
>  
>  	if(finish_command(&exporter))
> -- 
> 1.7.2.1.240.g6a95c3
> 
> 
